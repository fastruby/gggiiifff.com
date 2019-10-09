# config/shrine.rb

require "shrine"
require "shrine/storage/redis"

redis = Redis.new(url: REDIS_URL)

Shrine.storages = {
  cache: Shrine::Storage::Redis.new(
    client: redis,
    prefix: "cache",
    expire: 60
  ),
  store: Shrine::Storage::Redis.new(
    client: redis,
    prefix: "store",
    expire: 3600
  )
}

Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :restore_cached_data # refresh metadata when attaching the cached file
