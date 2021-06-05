# frozen_string_literal: true

require 'solidus_dev_support/rake_tasks'
require 'rubocop/rake_task'

SolidusDevSupport::RakeTasks.install
RuboCop::RakeTask.new

task default: %w(rubocop extension:specs)
