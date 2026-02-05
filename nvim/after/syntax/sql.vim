" after/syntax/sql.vim — ClickHouse extras on top of Vim's SQL regex highlighter
if exists("b:did_clickhouse_sql_overlay")
  finish
endif
let b:did_clickhouse_sql_overlay = 1

" Clauses (avoid over-highlighting single words like BY/KEY)
syntax match   chClause /\<ORDER\>\_s\+BY\>/
syntax match   chClause /\<PRIMARY\>\_s\+KEY\>/
syntax match   chClause /\<PARTITION\>\_s\+BY\>/
syntax match   chClause /\<ON\>\_s\+CLUSTER\>/
syntax keyword chClause ENGINE SETTINGS CODEC TTL SAMPLE FINAL FORMAT MATERIALIZED ALIAS

" Engines
syntax keyword chEngine MergeTree ReplacingMergeTree SummingMergeTree AggregatingMergeTree CollapsingMergeTree VersionedCollapsingMergeTree GraphiteMergeTree
syntax keyword chEngine ReplicatedMergeTree ReplicatedReplacingMergeTree ReplicatedSummingMergeTree ReplicatedAggregatingMergeTree ReplicatedCollapsingMergeTree ReplicatedVersionedCollapsingMergeTree
syntax keyword chEngine Kafka S3 File URL Log TinyLog StripeLog MaterializedView View

" Types
syntax keyword chType Enum8 Enum16 LowCardinality AggregateFunction SimpleAggregateFunction Nullable IPv4 IPv6 DateTime64 Tuple Map Array

" Functions (sample; extend if you want)
syntax keyword chFunc arrayJoin groupArray groupUniqArray uniq uniqExact uniqCombined quantile quantiles quantileTDigest median runningDifference cumsum argMax argMin toDateTime toDateTime64 parseDateTimeBestEffort now

" Parameters like {name:Type(...)}
syntax match   chParam /\v\{\w+:\w+(\([^}]*\))?\}/

" Uppercase enum strings: 'UNSPECIFIED', 'INTERNAL', ...
syntax match   chEnum  /'\u\{2,}'/

" Map to strong highlight groups (theme-agnostic)
highlight def link chClause Statement
highlight def link chEngine Type
highlight def link chType   Type
highlight def link chFunc   Function
highlight def link chParam  Special
highlight def link chEnum   Constant

