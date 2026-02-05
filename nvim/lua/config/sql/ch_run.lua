-- ~/.config/nvim/lua/config/sql/ch_run.lua
local function env(name, default) local v = vim.env[name]; return (v and v ~= "") and v or default end

local function run_clickhouse(selection_lines)
  local sql
  if selection_lines then sql = table.concat(selection_lines, "\n")
  else sql = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), "\n") end

  local args = {
    "clickhouse-client","--multiquery","--format","Pretty",
    "--host", env("CH_HOST","localhost"),
    "--port", env("CH_PORT","9000"),
    "--database", env("CH_DATABASE","default"),
  }
  local user, pass = env("CH_USER",""), env("CH_PASSWORD","")
  if user ~= "" then table.insert(args,"--user"); table.insert(args,user) end
  if pass ~= "" then table.insert(args,"--password"); table.insert(args,pass) end

  local buf = vim.api.nvim_create_buf(false,true)
  vim.api.nvim_buf_set_option(buf,"bufhidden","wipe")
  vim.api.nvim_buf_set_option(buf,"filetype","text")
  vim.api.nvim_open_win(buf,true,{relative="editor",width=math.floor(vim.o.columns*0.6),
    height=math.floor(vim.o.lines*0.5),row=2,col=5,border="rounded"})

  local out, err = {}, {}
  local job = vim.fn.jobstart(args,{
    stdout_buffered=true, stderr_buffered=true,
    on_stdout=function(_,d) if d then for _,l in ipairs(d) do table.insert(out,l) end end end,
    on_stderr=function(_,d) if d then for _,l in ipairs(d) do table.insert(err,l) end end end,
    on_exit=function(_,code)
      if code==0 then if #out==0 then table.insert(out,"[OK] (no output)") end
        vim.api.nvim_buf_set_lines(buf,0,-1,false,out)
      else if #err==0 then table.insert(err,"[clickhouse-client] exited "..code) end
        vim.api.nvim_buf_set_lines(buf,0,-1,false,err)
        vim.api.nvim_buf_add_highlight(buf,-1,"ErrorMsg",0,0,-1)
      end
    end,
  })
  if job>0 then vim.fn.chansend(job,sql); vim.fn.chanclose(job,"stdin") end
end

vim.keymap.set("n","<leader>cq",function() run_clickhouse() end,{desc="ClickHouse: run buffer"})
vim.keymap.set("v","<leader>cQ",function()
  local s = vim.fn.getpos("'<"); local e = vim.fn.getpos("'>")
  local srow,scol,erow,ecol = s[2],s[3],e[2],e[3]
  local lines = vim.api.nvim_buf_get_lines(0, srow-1, erow, true)
  if #lines>0 then lines[#lines] = lines[#lines]:sub(1,ecol); lines[1] = lines[1]:sub(scol) end
  run_clickhouse(lines)
end,{desc="ClickHouse: run selection"})

