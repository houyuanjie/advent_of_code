# Advent of Code Ruby Project

A structured Ruby project for solving Advent of Code puzzles with a convenient CLI and Rake tasks.

## Project Structure

```
advent_of_code/
├── bin/
│   └── aoc                    # Main CLI runner
├── year_2025/
│   ├── day_01/
│   │   ├── input.txt          # Puzzle input
│   │   ├── resolve_1.rb       # Part 1 solution
│   │   └── resolve_2.rb       # Part 2 solution
│   └── day_02/
│       ├── input.txt
│       ├── resolve_1.rb
│       └── resolve_2.rb
├── Rakefile                   # Rake tasks
├── Gemfile                    # Dependencies
└── README.md                  # This file
```

## Quick Start

From the project root, you can now run solutions with simple commands:

```bash
# Run part 1 of day 1, 2025
./run_aoc 2025 1 1

# Run part 2 of day 2, 2025
./run_aoc 2025 2 2

# Run tests for day 1, 2025
./run_aoc -y 2025 -d 1 -t

# Or use the full CLI
./bin/aoc -y 2025 -d 1 -p 1
```

## Installation

1. Clone the repository
2. Install dependencies:

```bash
bundle install
```

3. Make the scripts executable:

```bash
chmod +x bin/aoc run_aoc
```

## Usage

### Using the CLI

You have two options for running solutions:

**Option 1: Simple wrapper (recommended)**
```bash
# Using positional arguments
./run_aoc 2025 1 1          # Year, Day, Part

# Using named arguments
./run_aoc -y 2025 -d 2 -p 2
./run_aoc -y 2025 -d 1 -t   # Run tests

# Show help
./run_aoc -h
```

**Option 2: Full CLI**
```bash
# Run part 1 of day 1, 2025
./bin/aoc -y 2025 -d 1 -p 1

# Run part 2 of day 2, 2025
./bin/aoc -y 2025 -d 2 -p 2

# Run tests for day 1, 2025
./bin/aoc -y 2025 -d 1 -t

# Show help
./bin/aoc -h
```

### Using Rake Tasks

Rake provides additional convenience tasks for more advanced workflows:

Rake provides additional convenience tasks:

```bash
# List all available solutions
rake aoc:list

# Run a solution
rake aoc:run[2025,1,1]          # Year, Day, Part
# or using environment variables
YEAR=2025 DAY=1 PART=2 rake aoc:run

# Run tests
rake aoc:test[2025,1]
YEAR=2025 DAY=1 rake aoc:test

# Run all tests for a year
rake aoc:test_year[2025]
YEAR=2025 rake aoc:test_year

# Create template for a new day
rake aoc:new[2025,3]
YEAR=2025 DAY=3 rake aoc:new

# Show help
rake help
```

## Creating New Solutions

### Using the Template Generator

The easiest way to create a new day's solution:

```bash
rake aoc:new[2025,3]
```

This creates:
- `year_2025/day_03/resolve_1.rb` (part 1 template)
- `year_2025/day_03/resolve_2.rb` (part 2 template)
- `year_2025/day_03/input.txt` (empty input file)

### Manual Creation

1. Create directory: `mkdir -p year_2025/day_03`
2. Create solution files following the pattern (note: day numbers are now two-digit format):

```ruby
# frozen_string_literal: true

module Day3
  module_function

  def resolve(text)
    # Your solution here
  end

  def resolve_file(filename)
    resolve(File.read(filename))
  end
end

require 'minitest/autorun'

class Day3Test < Minitest::Test
  def test_it_works
    assert_equal 0, Day3.resolve(<<~TEXT)
      # Test input here
    TEXT
  end
end
```

3. Add your puzzle input to `input.txt`
4. Update the test with the example from the puzzle

## Development

### Running Tests

Each solution file includes its own tests. You can run them individually:

```bash
# From project root
ruby -I . year_2025/day_01/resolve_1.rb

# Using the CLI
./bin/aoc -y 2025 -d 1 -t

# Using Rake
rake aoc:test[2025,1]
```

### Code Quality

Run RuboCop to check code style:

```bash
# Check style
bundle exec rubocop

# Auto-correct issues
bundle exec rubocop -a

# Or use the default rake task
rake
```

## Dependencies

- Ruby (tested with 3.x)
- Bundler for gem management
- Gems:
  - `minitest` for testing
  - `rubocop` for code style
  - `rake` for task automation

## Tips

1. **Module Naming**: Use descriptive module names (e.g., `TurnTheDial`, `FindTheInvalidIDs`)
2. **Testing**: Include the example from the puzzle description in your tests
3. **Input Files**: Keep puzzle inputs in `input.txt` in each day's directory
4. **Performance**: For computationally intensive puzzles, consider optimizing your algorithms
5. **Debugging**: Add `puts` statements or use `pry` for debugging complex solutions

## Example Workflow

```bash
# Day 1
rake aoc:new[2025,1]
# Edit year_2025/day_01/resolve_1.rb with solution
# Add puzzle input to year_2025/day_01/input.txt
./run_aoc 2025 1 1

# Day 2 (after completing part 1)
# Edit year_2025/day_01/resolve_2.rb for part 2
./run_aoc 2025 1 2

# Run all tests to ensure everything works
rake aoc:test_year[2025]
```
