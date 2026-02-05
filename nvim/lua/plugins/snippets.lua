-- Snippet Engine
-- LuaSnip with custom snippets for Rust and Go

return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",  -- community snippet collection
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Navigation keymaps for snippet placeholders
      vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true, desc = "Expand snippet" })
      vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true, desc = "Jump to next placeholder" })
      vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true, desc = "Jump to previous placeholder" })
      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "Cycle through choices" })

      -- Rust snippets
      ls.add_snippets("rust", {
        -- Module documentation (//!)
        s("moddoc", {
          t("//! "), i(1, "Module description"),
          t({ "", "//!" }),
          t({ "", "//! # Examples" }),
          t({ "", "//!" }),
          t({ "", "//! ```" }),
          t({ "", "//! " }), i(2, "// example code"),
          t({ "", "//! ```" }),
        }),

        -- Item documentation (///)
        s("doc", {
          t("/// "), i(1, "Description"),
          t({ "", "///" }),
          t({ "", "/// # Arguments" }),
          t({ "", "///" }),
          t({ "", "/// * `" }), i(2, "arg"), t("` - "), i(3, "description"),
          t({ "", "///" }),
          t({ "", "/// # Returns" }),
          t({ "", "///" }),
          t({ "", "/// " }), i(4, "Return value description"),
          t({ "", "///" }),
          t({ "", "/// # Examples" }),
          t({ "", "///" }),
          t({ "", "/// ```" }),
          t({ "", "/// " }), i(0, "// example"),
          t({ "", "/// ```" }),
        }),

        -- Short doc comment
        s("///", { t("/// "), i(0, "Description") }),
        s("//!", { t("//! "), i(0, "Module description") }),

        -- Function
        s("fn", {
          t("fn "), i(1, "name"), t("("), i(2), t(") "), i(3, ""), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Test function
        s("test", {
          t("#[test]"),
          t({ "", "fn " }), i(1, "test_name"), t("() {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Test module
        s("cfg_test", {
          t("#[cfg(test)]"),
          t({ "", "mod tests {" }),
          t({ "", "    use super::*;" }),
          t({ "", "" }),
          t({ "", "    #[test]" }),
          t({ "", "    fn " }), i(1, "test_name"), t("() {"),
          t({ "", "        " }), i(0),
          t({ "", "    }" }),
          t({ "", "}" }),
        }),

        -- Derive attribute
        s("derive", { t("#[derive("), i(1, "Debug"), t(")]") }),
        s("allow", { t("#[allow("), i(1, "dead_code"), t(")]") }),

        -- Main function
        s("main", {
          t("fn main() {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Struct with derive
        s("struct", {
          t("#[derive(Debug"),
          t(", "), i(1), t(")]"),
          t({ "", "struct " }), i(2, "Name"), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Impl block
        s("impl", {
          t("impl "), i(1, "Type"), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Match expression
        s("match", {
          t("match "), i(1, "expression"), t(" {"),
          t({ "", "    " }), i(2, "pattern"), t(" => "), i(3, "expression"), t(","),
          t({ "", "    _ => " }), i(0),
          t({ "", "}" }),
        }),

        -- Control flow
        s("if let", {
          t("if let "), i(1, "Some(value)"), t(" = "), i(2, "option"), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        s("while let", {
          t("while let "), i(1, "Some(value)"), t(" = "), i(2, "option"), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        s("for", {
          t("for "), i(1, "item"), t(" in "), i(2, "iterator"), t(" {"),
          t({ "", "    " }), i(0),
          t({ "", "}" }),
        }),

        -- Debug macros
        s("println", { t("println!(\""), i(1), t("\");") }),
        s("eprintln", { t("eprintln!(\""), i(1), t("\");") }),
        s("dbg", { t("dbg!("), i(1), t(");") }),
        s("panic", { t("panic!(\""), i(1, "message"), t("\");") }),
        s("todo", { t("todo!(\""), i(1, "implement this"), t("\");") }),
        s("unimplemented", { t("unimplemented!(\""), i(1, "not yet implemented"), t("\");") }),

        -- Common types
        s("result", { t("Result<"), i(1, "T"), t(", "), i(2, "E"), t(">") }),
        s("option", { t("Option<"), i(1, "T"), t(">") }),
        s("vec", { t("Vec<"), i(1, "T"), t(">") }),
        s("hashmap", { t("HashMap<"), i(1, "K"), t(", "), i(2, "V"), t(">") }),
        s("rc", { t("Rc<"), i(1, "T"), t(">") }),
        s("arc", { t("Arc<"), i(1, "T"), t(">") }),
        s("mutex", { t("Mutex<"), i(1, "T"), t(">") }),
        s("rwlock", { t("RwLock<"), i(1, "T"), t(">") }),
      })

      -- Go snippets
      ls.add_snippets("go", {
        s("func", {
          t("func "), i(1, "name"), t("("), i(2), t(") "), i(3, ""), t(" {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("main", {
          t("func main() {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("test", {
          t("func Test"), i(1, "Name"), t("(t *testing.T) {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("benchmark", {
          t("func Benchmark"), i(1, "Name"), t("(b *testing.B) {"),
          t({ "", "\tfor i := 0; i < b.N; i++ {" }),
          t({ "", "\t\t" }), i(0),
          t({ "", "\t}" }),
          t({ "", "}" }),
        }),

        s("struct", {
          t("type "), i(1, "Name"), t(" struct {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("interface", {
          t("type "), i(1, "Name"), t(" interface {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("if err", {
          t("if err != nil {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("switch", {
          t("switch "), i(1, "expression"), t(" {"),
          t({ "", "case " }), i(2, "value"), t(":"),
          t({ "", "\t" }), i(3),
          t({ "", "default:" }),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("select", {
          t("select {"),
          t({ "", "case " }), i(1, "<-ch"), t(":"),
          t({ "", "\t" }), i(2),
          t({ "", "default:" }),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("for range", {
          t("for "), i(1, "key, value"), t(" := range "), i(2, "collection"), t(" {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("for", {
          t("for "), i(1, "i := 0; i < 10; i++"), t(" {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        s("go", {
          t("go func() {"),
          t({ "", "\t" }), i(0),
          t({ "", "}()" }),
        }),

        s("defer", {
          t("defer func() {"),
          t({ "", "\t" }), i(0),
          t({ "", "}()" }),
        }),

        s("method", {
          t("func ("), i(1, "r *Receiver"), t(") "), i(2, "MethodName"), t("("), i(3), t(") "), i(4, ""), t(" {"),
          t({ "", "\t" }), i(0),
          t({ "", "}" }),
        }),

        -- Print statements
        s("printf", { t("fmt.Printf(\""), i(1), t("\\n\", "), i(0), t(")") }),
        s("println", { t("fmt.Println("), i(0), t(")") }),
        s("sprintf", { t("fmt.Sprintf(\""), i(1), t("\", "), i(0), t(")") }),

        -- Make statements
        s("make chan", { t("make(chan "), i(1, "int"), i(2, ", 0"), t(")") }),
        s("make slice", { t("make([]"), i(1, "int"), t(", "), i(2, "0"), t(", "), i(3, "0"), t(")") }),
        s("make map", { t("make(map["), i(1, "string"), t("]"), i(2, "int"), t(")") }),
      })

      -- Load VSCode-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
