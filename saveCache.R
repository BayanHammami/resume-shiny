new_cache <- cache
new_cache[[args_hash]] <- cache_object
cache <- new_cache
assign('cache', cache, envir = .GlobalEnv)

if(save_cache_on_disk){
  cat('Saving cache on disk\n')
  saveRDS(cache, "./precalculated/cache.rds")
}