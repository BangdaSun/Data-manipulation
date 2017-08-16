library(stringr)
library(rvest)

### Example: extract data from github
mygit_repo = 'https://github.com/bangdasun?tab=repositories'
mygit_repo_html = html(mygit_repo)

# get the repositories' name
repo_selector = '.source a'
repo_name = html_nodes(mygit_repo_html, repo_selector) %>% 
  html_text() %>%
  str_replace('\n', '') %>%
  str_replace_all(' ', '')

repo_name

# get the repositories' info: main language and update info
repo_info_selector = '.mt-2'
repo_info = html_nodes(mygit_repo_html, repo_info_selector) %>%
  html_text() %>%
  str_replace_all('\n', '') %>%
  str_replace_all(' ', '') %>%
  str_replace_all('U', ' U') %>%
  str_replace_all('ed', 'ed ') %>%
  str_replace_all('Updated ', '')

# shaping and conversion
repo_info
repo_info_df = repo_info %>% 
  str_split(' ') %>% 
  unlist() %>%
  matrix(ncol = 2, byrow = TRUE) %>%
  as.data.frame()

# combine all info together
my_repo_df = data.frame(repo = repo_name,
                        language = repo_info_df[, 1],
                        update = repo_info_df[, 2]) 

my_repo_df
