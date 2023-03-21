config.load_autoconfig()

# Do not track
c.content.headers.do_not_track = True

# Downloads
c.downloads.location.directory = "~/Downloads/"
c.downloads.location.prompt = True
c.downloads.location.remember = True

# Search Engine
c.url.auto_search = 'naive'
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'yt'     : 'https://www.youtube.com/results?search_query={}',
    'wb'     : 'https://wiby.me/?q={}'
}
