# frozen_string_literal: true

require 'thinreports'

# http://www.thinreports.org/
class ThinReportsController < ApplicationController
  def index; end

  def output
    send_data(
      repository_list_with(outout_params[:github_user_name]),
      filename: "repository_list_#{outout_params[:github_user_name]}.pdf"
    )
  end

  private

  def repository_list_with(github_user_name)
    repositories = repositories(github_user_name)
    generate_pdf(github_user_name, repositories)
  end

  def repositories(github_user_name)
    response = Faraday.get("https://api.github.com/users/#{github_user_name}/repos")
    JSON.parse(response.body, symbolize_names: true)
  end

  def generate_pdf(github_user_name, repositories)
    report = Thinreports::Report.new layout: 'repository_list.tlf'

    write_header(report, github_user_name)
    write_list(report, repositories)

    report.generate
  end

  def write_header(report, github_user_name)
    report.list(:repository_list).header do |header|
      header.item(:text_block_header).value(
        "#{github_user_name}'s GitHub repository data"
      )
    end
  end

  def write_list(report, repositories)
    repositories.each do |repository|
      report.list(:repository_list).add_row do |row|
        %i[name description html_url language stargazers_count].each do |item|
          row.item(item).value(repository[item])
        end
      end
    end
  end

  def outout_params
    params.permit(:github_user_name, :authenticity_token, :commit)
  end
end
