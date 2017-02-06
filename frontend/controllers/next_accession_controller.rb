class NextAccessionController < ApplicationController

	set_access_control "view_repository" => [:index, :new],
	                   "update_accession_record" => [:create]

	def index
	end

	def new
		@id = fetch_id(params[:year])
	end

	def create
		response = post_accession(params)

		if response.code == '200'
			id = ASUtils.json_parse(response.body)['id']
			flash[:success] = I18n.t("plugins.next_accession.messages.success", :id => params[:id])
			redirect_to :controller => :accessions, :action => :show, :id => id
		else
			error = ASUtils.json_parse(response.body)['error']
			flash[:error] = "An error occurred: #{error}"
			redirect_to request.referer
		end
	end

	private

	def fetch_id(year)
		response = JSONModel::HTTP::post_form("/repositories/#{session[:repo_id]}/next_accession", {:year => year})
		json = ASUtils.json_parse(response.body)
		if json['id']
			return json['id']
		else
			flash[:error] = "#{json['error']}"
			redirect_to request.referer
		end
	end

	def post_accession(params)
		time = Time.new
		cmgmt = JSONModel(:collection_management).new({
			:processing_status => "in_progress"
		})

		record = JSONModel(:accession).new({
			:title => params[:title],
			:id_0 => params[:id],
			:accession_date => time.strftime("%Y-%m-%d"),
			:collection_management => cmgmt,
			:publish => false
		}).to_json

		url = URI("#{JSONModel::HTTP.backend_url}/repositories/#{session[:repo_id]}/accessions")
		resp = JSONModel::HTTP.post_json(url, record)

		resp
	end

end
