args_hash <- digest(args_val)
cat(glue('Args hash: {args_hash}\n'))
cache_names <- names(cache)

if(args_hash %in% cache_names){
  cat('Reading cache from memory\n')
  cached_object <- cache[[args_hash]]
  return(cached_object)
}
