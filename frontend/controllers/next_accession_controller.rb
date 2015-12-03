class NextAccessionController < ApplicationController

	set_access_control "view_repository" => [:index, :generate]

	def index
	end

	def generate
		acc_id = JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/next_accession", 'year' => params[:year])['next']

		return redirect_to(:controller => :accessions, :action => :new, :acc_id => acc_id)
	end

end
