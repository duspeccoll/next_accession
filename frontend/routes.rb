ArchivesSpace::Application.routes.draw do

  match('/plugins/next_accession' => 'next_accession#index', :via => [:get])
  match('/plugins/next_accession/generate' => 'next_accession#generate', :via => [:get])

end
