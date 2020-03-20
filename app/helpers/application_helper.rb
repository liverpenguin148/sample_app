module ApplicationHelper
  
  #ページごとタイトルを返す
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      # page_titleが空文字の場合,base_titleを返す
      base_title
    else
      # page_titleが空文字でない場合,以下の文字列を返す
      page_title + " | " + base_title
    end
  end
end
