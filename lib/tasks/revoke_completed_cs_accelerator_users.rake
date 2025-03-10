# frozen_string_literal: true

require 'csv'

namespace :csa do
  desc 'revoke CSA completion so that teacher may be asked to take the test again. Accepts DRYRUN (false) & VERBOSE (true) vars.'
  task revoke: :environment do |_argv|
    # Example invocation `rake csa:revoke DRYRUN=true`
    data_csv = 'csa_revoke.csv'
    dry_run = ActiveModel::Type::Boolean.new.cast(ENV.fetch('DRYRUN', 'false'))
    verbose = ActiveModel::Type::Boolean.new.cast(ENV.fetch('VERBOSE', 'true'))
    ActiveRecord::Base.transaction do
      CSV.foreach(data_csv, headers: true, skip_blanks: true) do |row|
        revoke_csa(user_details: row, dry_run:, verbose:)
      end
    rescue ArgumentError => e
      Rails.logger.warn "Failed to revoke CSA completion: #{e.inspect}"
    end
  end

  def revoke_csa(user_details:, dry_run:, verbose:)
    return unless (user = matching_user(user_details:, verbose:))

    remove_assessment_attempts(user:, user_details:, dry_run:, verbose:)
    unset_completed_enrolment(user:, user_details:, dry_run:, verbose:)
  end

  def matching_user(user_details:, verbose:)
    ['name', 'STEM ID', 'email'].each do |expected_key|
      raise ArgumentError, "CSV does not contain '#{expected_key}' column" unless user_details.key?(expected_key)
    end

    user = User.find_by(stem_achiever_contact_no: user_details['STEM ID'].downcase)
    if user.nil?
      puts "user with stem_achiever_contact_no #{user_details['STEM ID']} not found" if verbose
      return nil
    end
    return nil unless check_user_name(user:, user_details:, verbose:)

    return nil unless check_user_email(user:, user_details:, verbose:)

    user
  end

  def check_user_name(user:, user_details:, verbose:)
    unless (user_details['name'].downcase.include? user.first_name.downcase) && (user_details['name'].downcase.include? user.last_name.downcase)
      puts "#{user_details['STEM ID']} has the names #{user.first_name} #{user.last_name} in the database not #{user_details['name']} as in the CSV" if verbose
      return false
    end
    true
  end

  def check_user_email(user:, user_details:, verbose:)
    if user.email.downcase != user_details['email'].downcase
      puts "#{user_details['STEM ID']} has the email #{user.email} in the database not #{user_details['email']} as in the CSV" if verbose
      return false
    end
    true
  end

  def remove_assessment_attempts(user:, user_details:, dry_run:, verbose:)
    if verbose
      user.assessment_attempts.each do |assessment_attempt|
        puts "#{user_details['STEM ID']}: destroying #{assessment_attempt}"
      end
    end
    user.assessment_attempts.destroy_all unless dry_run
  end

  def unset_completed_enrolment(user:, user_details:, dry_run:, verbose:)
    user_programme_enrolment = user.user_programme_enrolments.find_by(programme_id: Programme.cs_accelerator.id)
    if user_programme_enrolment.nil?
      puts "CSA programme enrolment not found for #{user_details['STEM ID']}" if verbose
      return
    end
    puts "Resetting CSA programme enrolment for #{user_details['STEM ID']} from completed to enrolled" if verbose
    user_programme_enrolment.transition_to(:enrolled) unless dry_run
  end
end
