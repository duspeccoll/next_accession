class NextAccessionController < ApplicationController

	set_access_control "view_repository" => [:index, :generate]

	def index
	end

	def generate
		acc_id = JSONModel::HTTP::post_json("/repositories/#{session[:repo_id]}/next_accession", 'year' => params[:year])['id']
		
		return redirect_to(:controller => :accessions, :action => :new, :year => params[:year])
	end

end
