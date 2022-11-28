library(tidyverse)

df <- read_delim('raw_data/nbs-data.csv', delim = ' ### ')

names(df) <- c('x008', 'x260c', 'x264c', 'x260a', 'x264a', 'x245c', 'x100a', 'x700a')
df2 <- df %>% 
  mutate(
    date = ifelse(!is.na(x260c), x260c, x264c),
    city = ifelse(!is.na(x260a), x260a, x264a)
  ) %>% 
  select(-c(x260c, x264c, x260a, x264a)) %>% 
  mutate(city = str_replace(city, " :.*$", "")) %>% 
  mutate(city = str_replace(city, ", *$", "")) %>% 
  mutate(city = str_replace(city, "\\[ ?(.*?)\\]$", "\\1")) %>% 
  mutate(city = str_replace(city, "\\[ ?(.*?)$", "\\1")) %>% 
  mutate(city = str_replace(city, "\\( ?(.*?) ?\\)$", "\\1")) %>% 
  mutate(city = str_replace(city, ":$", "")) %>% 
  mutate(city = str_replace(city, "^(Edin|Edinr|Edinburgh|Edinbr)\\. ?$", "Edinburgh")) %>% 
  mutate(city = str_replace(city, "Edinburghand", "Edinburgh and")) %>% 
  mutate(city = str_replace(city, "(\\w{2,})\\.$", "\\1")) %>% 
  mutate(city = str_replace(city, " ;$", "")) %>% 
  mutate(city = str_replace_all(city, "\\|\\|", " # ")) %>% 
  mutate(city = str_replace(city, " ?; ?#", " # ")) %>% 
  mutate(city = str_replace(city, "#  ", "# ")) %>% 
  mutate(city = str_replace(city, "#  ", "# ")) %>% 
  mutate(city = str_replace(city, "\\] #", " #")) %>% 
  mutate(city = str_replace(city, " +#", " #")) %>% 
  mutate(city = str_replace(city, " ?[;:] #", " #")) %>% 
  mutate(city = str_replace(city, ", (David Bryce and Son|Adam and Charles Black|Edmonston and Douglas|Printed by Anderson & Bryce|William Blackwood and Sons)", "")) %>% 
  mutate(city = str_replace(city, "# and", "#")) %>% 
  mutate(city = str_replace(city, ": Archibald Constable and Co.,", '')) %>% 
  mutate(city = str_replace(city, ": Printed and sold by Charles Dickson, printer to the Church of Scotland", '')) %>% 
  mutate(city = str_replace(city, ": printed for John Anderson and Company, and for Longman, Hurst, Rees, Orme, and Brown, London. ", " # London")) %>% 
  mutate(city = str_replace(city, ": Published by William Whyte.*$", '')) %>% 
  mutate(city = str_replace(city, ": printed by W. Scott, and sold by T. Stewart", '')) %>%
  mutate(city = str_replace(city, ", Gall & Inglis, 6 George Street", "")) %>% 
  mutate(city = str_replace(city, ", Oliver & Boyd, Tweeddale Court", "")) %>% 
  mutate(city = str_replace(city, ": printed for Peter Hill, ... by Murray & Cochrane, ... 1808", "")) %>% 
  mutate(city = str_replace(city, "Glasgow\\] j. Lithgow & Son, Steam-Power Printers, 34 Ann St. \\(City\\), Glasgow", "Glasgow")) %>% 
  mutate(city = str_replace(city, "Edinburgh # Glasgow: # Dublin: # W. Curry & Co., # London: # Hamilton, Adams, & Co", "Edinburgh # Glasgow # Dublin # London")) %>% 
  mutate(city = str_replace(city, "^(S.l|s.l|S. l|S.I|s.l.\\]|S.L|S.l.|S.l.\\]|s. l|s\\.l\\.)$", "S. l.")) %>% 
  mutate(city = str_replace(city, "^Glasgow, Edinburgh,? & London$", "Glasgow # Edinburgh # London")) %>% 
  mutate(city = str_replace(city, "^Edinburgh, Glasgow & London$", "Edinburgh # Glasgow # London")) %>% 
  mutate(city = str_replace(city, "^Edinburgh, Glasgow & London$", "Edinburgh # Glasgow # London")) %>% 
  mutate(city = str_replace(city, "Edinburgh, Glasgow, Belfast,? London & New York", "Edinburgh # Glasgow # Belfast # London # New York")) %>% 
  mutate(city = str_replace(city, " & ", " # ")) %>% 
  mutate(city = str_replace(city, ", and ", " and ")) %>% 
  mutate(city = str_replace(city, "London; Edinburgh; and New York", "London # Edinburgh # New York")) %>% 
  mutate(city = str_replace(city, "Edinburgh, Glasgow and London", "Edinburgh # Glasgow # London")) %>% 
  mutate(city = str_replace(city, "Glasgow, Edinburgh and London", "Glasgow # Edinburgh # London")) %>% 
  mutate(city = str_replace(city, "Glasgow, Edinburgh, London and New York", "Glasgow # Edinburgh # London # New York")) %>% 
  mutate(city = str_replace(
    city,
    "Greenock and W. Scott, Greenock; M. Currie, Port-Glasgow; Brash and Reid, W. Turnbull, and Potter and Co. Glasgow; H. Crichton, Paisley; Rankin, Falkirk; Crawford, Kilmarnock; Robinson, ... and Bryce and Co. ... Edinburgh",
    "Greenock")) %>% 
  mutate(city = str_replace(city, "Perth, Edinburgh and Glasgow", "Perth # Edinburgh # Glasgow")) %>% 
  mutate(city = str_replace(city, "Paisley; and Paternoster Square, London", "Paisley # London")) %>% 
  mutate(city = str_replace(city, "Paisley and ... London", "Paisley # London")) %>% 
  mutate(city = str_replace(city, " and ", " # ")) %>% 
  mutate(city = str_replace(city, "(St Andrews|St Andrew's|St. Andrew's)", "St. Andrews")) %>% 
  mutate(city = str_replace(city, "[,;: \\]-]+$", "")) %>% 
  mutate(city = str_replace(city, "\\]\\.$", '')) %>% 
  mutate(city = str_replace(city, " ?\\?\\.?$", "?")) %>% 
  mutate(city = str_replace(city, "^(Edinburgi|Edin\\.? ?|Edinb\\.|Edinr)(\\?)?$", "Edinburgh\\2")) %>% 
  mutate(city = str_replace(city, "^(Glasgow|Glasg|Glasguae|Glascho|Glaschu|Glasguæ|Glasgho|Glasgow,? Scotland|Glasglow|Glasguae Glasgow|Glasow|Glascho Glasgow|Glasco|Glasgo|Glasgoe|Glasgow etc|Glasgow, Scot|Glasgow: James Maclehose, 61 St. Vincent Street|GlasguÆ|Glasgue)\\.?$", "Glasgow")) %>% 
  mutate(city = str_replace(city, "^Glasgow, Edinburgh$", "Glasgow # Edinburgh")) %>% 
  mutate(city = str_replace(city, "^(Edinburgh, Glasgow|Edinburgh Glasgow)$", "Edinburgh # Glasgow")) %>% 
  mutate(city = str_replace(city, "^Paisley, Glasgow$", "Paisley # Glasgow")) %>% 
  mutate(city = str_replace(city, "^Glasgow, London$", "Glasgow # London")) %>% 
  mutate(city = str_replace(city, "^(Glasgow: Edinburgh|Glasgow Edinburgh)$", "Glasgow # Edinburgh")) %>% 
  mutate(city = str_replace(city, "^Glasgow, Edinburgh, London, New York$", "Glasgow # Edinburgh # London # New York")) %>% 
  mutate(city = str_replace(city, "^(Aberdeen Scotland|Aberdeen etc|\\{Aberdeen|Aberdeen|Aberdoniae)\\.?$", "Aberdeen")) %>% 
  mutate(city = str_replace(city, ",? Scotland$", "")) %>% 
  mutate(city = str_replace(city, ", Edinburgh$", " # Edinburgh")) %>% 
  
  mutate(city = str_replace_all(city, " ; ", " # ")) %>% 
  mutate(city = str_replace_all(city, "; # ", " # ")) %>% 
  mutate(city = str_replace_all(city, ": # ", " # ")) %>% 
  mutate(city = str_replace_all(city, ", # ", " # ")) %>% 
  mutate(city = str_replace_all(city, "; ", " # ")) %>% 
  mutate(x008 = str_replace(x008, "( |-|x){2}$", "uu")) %>% 
  mutate(x008 = str_replace(x008, "( |-|x)$", "u")) %>% 
  mutate(x700a = str_replace_all(x700a, "\\|\\|", " # ")) %>% 
  mutate(x100a = str_replace_all(x100a, "\\|\\|", " # "))

# keep only 19th century data
df19 <- df2 %>% 
  filter(substr(x008, 0, 2) == "18")

# 18th century publication places  
df19 %>% 
  select(city) %>% 
  group_by(city) %>% 
  count() %>% 
  # filter(grepl("\\W$", city)) %>% 
  arrange(desc(n)) %>% 
  view()

# books by dates
df19 %>% 
  select(x008) %>% 
  group_by(x008) %>% 
  count() %>% 
  view()

# authors
df19 %>%
  select(x100a) %>%
  group_by(x100a) %>% 
  count() %>% 
  view('authors')

# top cities
df19 %>% 
  filter(city %in% c('Edinburgh', 'Glasgow', 'Aberdeen')) %>% 
  group_by(x008, city) %>% 
  count() %>% 
  mutate(x008 = as.numeric(x008)) %>% 
  ggplot(aes(y = city, x = x008, color=n, size=n)) +
  geom_point(show.legend = FALSE) +
  theme_bw() +
  labs(title = 'Top cities') +
  ylab('nr. of publications') +
  xlab('publication year')

# get COMHIS's author's list
authors <- read_tsv('raw_data/full_scottish_authors.tsv')

# view authors
authors %>%
  select(name_unified) %>%
  view()

# select only those which have a proper dates, and separate name and date part
dated_authors <- authors %>% 
  select(name_unified) %>%
  filter(grepl(', 1\\d{3}-1\\d{3}.$', name_unified)) %>% 
  mutate(
    name = str_replace(name_unified, ', 1\\d{3}-1\\d{3}.$', ''),
    date = str_replace(name_unified, '^.*, (1\\d{3}-1\\d{3}.)$', '\\1')
  ) %>% 
  filter(!grepl('\\[', name)) %>% 
  select(-name_unified)
nrow(dated_authors)
names <- dated_authors %>% select(name) %>% unlist(use.names = FALSE)
dates <- dated_authors %>% select(date) %>% unlist(use.names = FALSE)

# check each authors in NBS
rows <- c()
for (i in 1:length(names)) {
  name <- names[i]
  date <- dates[i]

  filtered <- df19 %>% 
    filter(grepl(name, x700a) | grepl(name, x100a)) %>% 
    filter(x008 != '18uu')
  rows <- c(rows, nrow(filtered))
  if (nrow(filtered) > 0) {
    title <- paste(name, date, sep = ', ')
    print(title)
    print(num_rows)

    city_date <- filtered %>% 
      select(x008, city) %>% 
      group_by(x008, city) %>% 
      count() %>% 
      mutate(x008 = as.integer(x008))

    g <- ggplot(data = city_date, aes(y = city, x = x008)) +
      geom_point(aes(size = n), show.legend = FALSE) +
      theme_bw() +
      labs(title = title) +
      ylab('publication place') +
      xlab('publication year')
    
    filename <- paste0('img/', sprintf("%03d", i), '.png')
    print(filename)

    # png(filename, width=400, height=400, pointsize=30)
    # print(g)
    # dev.off()
    ggsave(filename, g, width=5, height=4, units = "in", dpi=300)
  }
}

dated_authors$rows <- rows
write_csv(dated_authors, 'data/dated_authors.csv')
