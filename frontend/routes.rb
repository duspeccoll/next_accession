ArchivesSpace::Application.routes.draw do

  match('/plugins/next_accession' => 'next_accession#index', :via => [:get])
  match('/plugins/next_accession/get' => 'next_accession#get', :via => [:get])
  match('/plugins/next_accession/create' => 'next_accession#create', :via => [:get])

end
