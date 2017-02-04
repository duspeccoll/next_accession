class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/next_accession')
    .description("Gets the next accession number for the year provided")
    .params(["repo_id", :repo_id],
            ["year", String, "The year in which the accession is generated"])
    .permissions(["view_repository"])
    .returns([200, "OK"]) \
  do
    json = next_accession_id(params[:year])

    json_response(json)
  end

  private

  def is_valid_year?(year)
    d = Date.new(year.to_i)
    return d.gregorian?
  end

  def next_accession_id(year)
    json = {}
    if is_valid_year?(year)
      dataset = CrudHelpers.scoped_dataset(Accession, {}).map{|rec| rec[:id_0]}.delete_if{|x| !x.start_with?(params[:year])}
      if dataset.nil? || dataset.empty?
        next_id = year.concat(".001")
      else
        id = (dataset.max.sub("#{year}.", "").to_i)+1
        next_id = year.concat(".").concat(id.to_s.rjust(3, '0'))
      end
      json['id'] = next_id
    else
      json['error'] = "Please enter a valid year"
    end

    json
  end
end
