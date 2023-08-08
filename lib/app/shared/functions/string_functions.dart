String removePrefix(String url) {
  String prefix = "https://duckduckgo.com/";
  if (url.startsWith(prefix)) {
    return url.substring(prefix.length);
  }
  return url;
}
