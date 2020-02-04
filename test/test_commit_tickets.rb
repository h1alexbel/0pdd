# Copyright (c) 2016-2020 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'test/unit'
require 'yaml'
require_relative 'test__helper'
require_relative '../objects/commit_tickets'

# CommitTickets test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2016-2020 Yegor Bugayenko
# License:: MIT
class TestCommitTickets < Test::Unit::TestCase
  def test_submits_tickets
    sources = Object.new
    def sources.config
      YAML.safe_load(
        "
alerts:
  suppress:
    - on-found-puzzle"
      )
    end
    tickets = Object.new
    def tickets.submit(_)
      {}
    end
    tickets = CommitTickets.new('yegor256/0pdd', sources, nil, nil, tickets)
    tickets.submit(nil)
  end

  def test_closes_tickets
    sources = Object.new
    def sources.config
      YAML.safe_load(
        "
alerts:
  suppress:
    - on-lost-puzzle"
      )
    end
    tickets = Object.new
    def tickets.close(_)
      {}
    end
    tickets = CommitTickets.new('yegor256/0pdd', sources, nil, nil, tickets)
    tickets.close(nil)
  end

  def test_scope_supressed_repo_should_be_quiet
    sources = Object.new
    def sources.config
      YAML.safe_load(
        "
alerts:
  suppress:
    - on-scope"
      )
    end
    tickets = Object.new
    def tickets.submit(_)
      {}
    end
    tickets = CommitTickets.new('yegor256/0pdd', sources, nil, nil, tickets)
    tickets.submit(nil)
  end
end
