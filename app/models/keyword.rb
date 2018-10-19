class Keyword < ActiveRecord::Base
  has_many :job_keywords, dependent: :destroy
  has_many :jobs, through: :job_keywords

  scope :technology, -> { where(kind: 'technology') }
  scope :location, -> { where(kind: 'location') }

  FINDERS = {
    technology: {
      android:        -> { Job.matching_words(%w(android)) },
      angular:        -> { Job.matching_words(%w(angular angularjs)) },
      c:              -> { Job.matching_text_sensitive('\sC(,\s|\.\s|/)')
                             .merge(Job.matching_text_sensitive('(?<!bj)(?<!bjective)\sC(,\s|\.\s|/)')) },
      clojure:        -> { Job.matching_words(%w(clojure)) },
      cplusplus:      -> { Job.matching_text(%w(c\+\+)) },
      csharp:         -> { Job.matching_text(%w(c#)) },
      django:         -> { Job.matching_words(%w(django)) },
      elixir:         -> { Job.matching_words(%w(elixir)) },
      elm:            -> { Job.matching_words(%w(elm)) },
      ember:          -> { Job.matching_words(%w(ember emberjs)) },
      go:             -> { Job.matching_words(%w(golang)).or(Job.matching_text_sensitive('\yGo\y')) },
      ios:            -> { Job.matching_words(%w(ios)) },
      java:           -> { Job.matching_words(%w(java)) },
      javascript:     -> { Job.matching_words(%w(javascript)) },
      kotlin:         -> { Job.matching_words(%w(kotlin)) },
      node:           -> { Job.matching_words(%w(node nodejs)) },
      php:            -> { Job.matching_words(%w(php)) },
      python:         -> { Job.matching_words(%w(python django)) },
      rails:          -> { Job.matching_words(%w(rails ror)) },
      react:          -> { Job.matching_text('\yreact\y(?!(-|\s)native)').or(Job.matching_words(%w(reactjs))) },
      'react-native': -> { Job.matching_words(%w(react-native)).or(Job.matching_text('react native')) },
      ruby:           -> { Job.matching_words(%w(ruby rails ror)) },
      rust:           -> { Job.matching_words(%w(rust)) },
      scala:          -> { Job.matching_words(%w(scala)) },
      swift:          -> { Job.matching_words(%w(swift)) },
      vue:            -> { Job.matching_words(%w(vue vuejs)) }
    },
    location: {
      'amsterdam': -> { Job.matching_words(%w(Amsterdam)) },
      'berlin': -> { Job.matching_words(%w(Berlin)) },
      'dublin': -> { Job.matching_words(%w(Dublin)) },
      'london': -> { Job.matching_words(%w(London)) },
      'new-york': -> { Job.matching_words(['New York', 'NYC']) },
      'san-francisco': -> { Job.matching_words(['San Francisco', 'SF']) },
      'seattle': -> { Job.matching_words(%w(Seattle)) },
      'toronto': -> { Job.matching_words(%w(Toronto)) }
    }
  }

  def self.populate!
    FINDERS.each do |kind, finders|
      Keyword.where(kind: kind).where.not(slug: finders.keys).destroy_all
      finders.each do |slug, finder|
        keyword = find_or_create_by!(slug: slug, kind: kind)
        jobs_scope = finder.call
        jobs_scope.where.not(id: keyword.jobs).find_each do |job|
          job.keywords << keyword
        end
        keyword.job_keywords.joins(:job).where.not(jobs: { id: jobs_scope }).destroy_all
      end
    end
  end

  def to_param
    slug
  end
end
