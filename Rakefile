# frozen_string_literal: true

require 'rubocop/rake_task'
RuboCop::RakeTask.new

namespace :aoc do
  desc 'Run solution for a specific year, day, and part'
  task :run, [:year, :day, :part] do |_t, args|
    year = args[:year] || ENV.fetch('YEAR', nil)
    day = args[:day] || ENV.fetch('DAY', nil)
    part = args[:part] || ENV['PART'] || '1'

    unless year && day
      puts 'Usage: rake aoc:run[year,day,part] or set YEAR, DAY, PART environment variables'
      puts 'Example: rake aoc:run[2025,1,1]'
      puts 'Example: YEAR=2025 DAY=1 PART=2 rake aoc:run'
      exit 1
    end

    sh "./bin/aoc -y #{year} -d #{day} -p #{part}"
  end

  desc 'Run tests for a specific year and day'
  task :test, [:year, :day] do |_t, args|
    year = args[:year] || ENV.fetch('YEAR', nil)
    day = args[:day] || ENV.fetch('DAY', nil)

    unless year && day
      puts 'Usage: rake aoc:test[year,day] or set YEAR, DAY environment variables'
      puts 'Example: rake aoc:test[2025,1]'
      puts 'Example: YEAR=2025 DAY=1 rake aoc:test'
      exit 1
    end

    sh "./bin/aoc -y #{year} -d #{day} -t"
  end

  desc 'Run all tests for a specific year'
  task :test_year, [:year] do |_t, args|
    year = args[:year] || ENV.fetch('YEAR', nil)

    unless year
      puts 'Usage: rake aoc:test_year[year] or set YEAR environment variable'
      puts 'Example: rake aoc:test_year[2025]'
      puts 'Example: YEAR=2025 rake aoc:test_year'
      exit 1
    end

    year_dir = "year_#{year}"
    unless Dir.exist?(year_dir)
      puts "Year #{year} directory not found"
      exit 1
    end

    puts "Running all tests for year #{year}..."
    Dir.glob("#{year_dir}/day_*").each do |day_dir|
      day = day_dir.match(/day_(\d+)/)[1]
      puts "\n=== Day #{day.to_i} ==="

      # Test part 1
      resolve_1 = "#{day_dir}/resolve_1.rb"
      if File.exist?(resolve_1)
        puts 'Part 1:'
        begin
          sh "ruby -I . #{resolve_1}"
        rescue StandardError
          puts '  Test failed (template or implementation issue)'
        end
      end

      # Test part 2
      resolve_2 = "#{day_dir}/resolve_2.rb"
      next unless File.exist?(resolve_2)

      puts 'Part 2:'
      begin
        sh "ruby -I . #{resolve_2}"
      rescue StandardError
        puts '  Test failed (template or implementation issue)'
      end
    end
  end

  desc 'List available solutions'
  task :list do
    puts 'Available Advent of Code solutions:'

    Dir.glob('year_*').each do |year_dir|
      year = year_dir.match(/year_(\d+)/)[1]
      puts "\nYear #{year}:"

      Dir.glob("#{year_dir}/day_*").each do |day_dir|
        day = day_dir.match(/day_(\d+)/)[1]
        parts = []
        parts << '1' if File.exist?("#{day_dir}/resolve_1.rb")
        parts << '2' if File.exist?("#{day_dir}/resolve_2.rb")

        puts "  Day #{day.to_i}: parts #{parts.join(', ')}" if parts.any?
      end
    end
  end

  desc 'Create template for a new day'
  task :new, [:year, :day] do |_t, args|
    year = args[:year] || ENV.fetch('YEAR', nil)
    day = args[:day] || ENV.fetch('DAY', nil)

    unless year && day
      puts 'Usage: rake aoc:new[year,day] or set YEAR, DAY environment variables'
      puts 'Example: rake aoc:new[2025,3]'
      puts 'Example: YEAR=2025 DAY=3 rake aoc:new'
      exit 1
    end

    year_dir = "year_#{year}"
    day_dir = "#{year_dir}/day_#{day.to_s.rjust(2, '0')}"

    # Create directories
    mkdir_p year_dir unless Dir.exist?(year_dir)
    mkdir_p day_dir unless Dir.exist?(day_dir)

    # Create template files
    template = <<~RUBY
      # frozen_string_literal: true

      module Day#{day}
        module_function

        def resolve(text)
          # Your solution here
        end

        def resolve_file(filename)
          resolve(File.read(filename))
        end
      end

      require 'minitest/autorun'

      class Day#{day}Test < Minitest::Test
        def test_it_works
          assert_equal 0, Day#{day}.resolve(<<~TEXT)
            # Test input here
          TEXT
        end
      end
    RUBY

    # Create part 1
    resolve_1 = "#{day_dir}/resolve_1.rb"
    if File.exist?(resolve_1)
      puts "Part 1 already exists at #{resolve_1}"
    else
      File.write(resolve_1, template)
      puts "Created #{resolve_1}"
    end

    # Create part 2
    resolve_2 = "#{day_dir}/resolve_2.rb"
    if File.exist?(resolve_2)
      puts "Part 2 already exists at #{resolve_2}"
    else
      File.write(resolve_2, template)
      puts "Created #{resolve_2}"
    end

    # Create empty input file
    input_file = "#{day_dir}/input.txt"
    if File.exist?(input_file)
      puts "Input file already exists at #{input_file}"
    else
      File.write(input_file, '')
      puts "Created #{input_file}"
    end

    puts "\nTemplate created for year #{year}, day #{day}"
    puts "Run with: rake aoc:run[#{year},#{day},1]"
  end
end

desc 'Run rubocop autocorrect'
task default: %i[rubocop:autocorrect]

desc 'Show help for Advent of Code tasks'
task :help do
  puts 'Advent of Code Tasks:'
  puts '  rake aoc:run[year,day,part]    - Run solution'
  puts '  rake aoc:test[year,day]        - Run tests'
  puts '  rake aoc:test_year[year]       - Run all tests for a year'
  puts '  rake aoc:list                  - List available solutions'
  puts '  rake aoc:new[year,day]         - Create template for new day'
  puts '  rake help                      - Show this help'
  puts ''
  puts 'Environment variables can be used instead of arguments:'
  puts '  YEAR=2025 DAY=1 PART=2 rake aoc:run'
  puts ''
  puts 'Or use the CLI directly:'
  puts '  ./bin/aoc -y 2025 -d 1 -p 2'
end
