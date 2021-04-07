ArchivesSpace::Application.routes.draw do

  [AppConfig[:frontend_proxy_prefix], AppConfig[:frontend_prefix]].uniq.each do |prefix|
    scope prefix do
      match('/plugins/next_accession' => 'next_accession#index', :via => [:get])
      match('/plugins/next_accession/new' => 'next_accession#new', :via => [:post])
      match('/plugins/next_accession/create' => 'next_accession#create', :via => [:get])
    end
  end
end
