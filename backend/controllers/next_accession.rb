class ArchivesSpaceService < Sinatra::Base

  Endpoint.get('/repositories/:repo_id/next_accession')
    .description("Gets the next accession number for the year provided")
    .params(["repo_id", :repo_id],
            ["year", String, "The year in which the accession is generated"])
    .permissions(["view_repository"])
    .returns([200, "OK"]) \
  do
    dataset = CrudHelpers.scoped_dataset(Accession, {}).map { |rec| rec[:id_0] }.delete_if { |x| !x.start_with?(params[:year]) }
    if dataset.nil? || dataset.empty?
      next_id = params[:year].concat(".001")
    else
      id = dataset.max.sub("#{params[:year]}.", "").to_i
      id = id + 1
      next_id = params[:year].concat(".").concat(id.to_s.rjust(3, '0'))
    end
    json_response(:id => next_id)
  end

end
