; ---- ClickHouse overlay for tree-sitter-sql (matches your node names) ----
; Engines after ENGINE =
((identifier) @ch_engine
  (#match? @ch_engine "^(MergeTree|ReplacingMergeTree|SummingMergeTree|AggregatingMergeTree|CollapsingMergeTree|VersionedCollapsingMergeTree|GraphiteMergeTree|ReplicatedMergeTree|ReplicatedReplacingMergeTree|ReplicatedSummingMergeTree|ReplicatedAggregatingMergeTree|ReplicatedCollapsingMergeTree|ReplicatedVersionedCollapsingMergeTree|Kafka|S3|File|URL|Log|TinyLog|StripeLog|MaterializedView|View)$"))

; CH-specific type names
((type_name) @ch_type
  (#match? @ch_type "^(Enum8|Enum16|LowCardinality|AggregateFunction|SimpleAggregateFunction|Nullable|IPv4|IPv6|DateTime64|Tuple|Map|Array)$"))

; Common CH functions
((function_call name: (identifier) @ch_func)
  (#match? @ch_func "^(arrayJoin|groupArray|groupUniqArray|uniq|uniqExact|uniqCombined|quantile|quantiles|quantileTDigest|median|runningDifference|cumsum|argMax|argMin|toDateTime|toDateTime64|parseDateTimeBestEffort|now)$"))

; CH clause-like keywords appear as many distinct keyword_* nodes in this grammar.
; Match identifiers that are written as uppercase clause words too.
((identifier) @ch_clause
  (#match? @ch_clause "^(ENGINE|SETTINGS|CODEC|TTL|SAMPLE|FINAL|FORMAT|MATERIALIZED|ALIAS|PARTITION|PRIMARY|ORDER|BY|ON|CLUSTER)$"))

; Uppercase enum string values: 'UNSPECIFIED', 'INTERNAL', ...
; In this grammar strings are simple tokens, so regex on the full text works.
((string) @ch_enum
  (#match? @ch_enum "^'([A-Z_]+)'$"))

