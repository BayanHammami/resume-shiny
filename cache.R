args_hash <- digest(args_val)
args_hash <- glue("{args_hash}.rds")
cached_files <- list.files('./precalculated/')
path_to_cache_file <- glue("./precalculated/{args_hash}")

if(args_hash %in% cached_files){
  p <- readRDS(path_to_cache_file)
  return(p)
}
