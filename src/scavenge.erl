-module(scavenge).
-export([urls2htmlFile/2, bin2urls/1]).
-import(lists, [reverse/1, reverse/2, map/2]).

urls2htmlFile(Urls, File) ->
    file:write_file(File, bin2urls(Urls)).

gather_urls("<a href" ++ T, L) ->
    {Url, T1} = collect_url_body(T, reverse("<a href")),
    gather_urls(T1, [Url|L]);
gather_urls([_|T], L) ->
    gather_urls(T, L);
gather_urls([], L) ->
    L.

collect_url_body("</a>" ++ T, L) -> {reverse(L, "</a>"), T};
collect_url_body([H|T], L) -> collect_url_body(T, [H|L]);
collect_url_body([], _) -> {[], []}.

bin2urls(Bin) -> gather_urls(binary_to_list(Bin), []).

urls2html(Urls) -> [h1("Urls"), make_list(Urls)].

h1(Title) -> ["<h1>", Title, "</h1>\n"].

make_list(L) ->
    ["<ul>\n", map(fun(I) -> ["<li>", I, "</li>\n"] end, L), "</ul>\n"].




