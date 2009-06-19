module Unfuzzle
  class Milestone

    include Unfuzzle::Model

    attribute :id
    attribute :archived
    attribute :name, :from => :title
    attribute :created_timestamp, :from => :created_at
    attribute :updated_timestamp, :from => :updated_at
    attribute :due_datestamp, :from => :due_on

    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/milestones")
      response.data.map {|data| new(data) }
    end

    def archived?
      archived == true
    end

    def created_at
      DateTime.parse(created_timestamp)
    end

    def updated_at
      DateTime.parse(updated_timestamp)
    end

    def due_on
      Date.parse(due_datestamp)
    end

  end
end