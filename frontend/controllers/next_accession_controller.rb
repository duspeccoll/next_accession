class NextAccessionController < ApplicationController

	set_access_control "view_repository" => [:index, :get],
	                   "update_accession_record" => [:create, :build]

	def index
	end

	def get
		render :json => JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/next_accession", 'year' => params[:year])
	end

	def create
		accession = build(params[:id])
		url = URI("#{JSONModel::HTTP.backend_url}/repositories/#{session[:repo_id]}/accessions")
		response = JSONModel::HTTP::post_json(url, accession)
		if response.code === "200"
			acc_id = ASUtils.json_parse(response.body)['id']
			flash[:success] = I18n.t("plugins.next_accession.messages.success", :id => params[:id])
			redirect_to :controller => :accessions, :action => :show, :id => acc_id
		else
			errors = ASUtils.json_parse(response.body)['error']
			flash[:error] = I18n.t("plugins.next_accession.messages.error", :id => params[:id])
			redirect_to request.referer
		end
	end

	private

	def build(id)
		time = Time.new
		record = JSONModel(:accession).new({
			:id_0 => id,
			:accession_date => time.strftime("%Y-%m-%d"),
			:publish => false
		}).to_json

		record
	end

end
