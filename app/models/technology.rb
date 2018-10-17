class Technology < ActiveRecord::Base
  has_many :job_technologies, dependent: :destroy
  has_many :jobs, through: :job_technologies

  DEFINITIONS = {
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
    ios:            -> { Job.matching_words(%w(ios)) },
    java:           -> { Job.matching_words(%w(java)) },
    javascript:     -> { Job.matching_words(%w(javascript)) },
    kotlin:         -> { Job.matching_words(%w(kotlin)) },
    node:           -> { Job.matching_words(%w(node nodejs)) },
    php:            -> { Job.matching_words(%w(php)) },
    python:         -> { Job.matching_words(%w(python django)) },
    rails:          -> { Job.matching_words(%w(rails)) },
    react:          -> { Job.matching_text('\yreact\y(?!(-|\s)native)').or(Job.matching_words(%w(reactjs))) },
    'react-native': -> { Job.matching_words(%w(react-native)).or(Job.matching_text('react native')) },
    ruby:           -> { Job.matching_words(%w(ruby rails)) },
    rust:           -> { Job.matching_words(%w(rust)) },
    scala:          -> { Job.matching_words(%w(scala)) },
    swift:          -> { Job.matching_words(%w(swift)) },
    vue:            -> { Job.matching_words(%w(vue vuejs)) }
  }

  def self.populate!
    Technology.where.not(slug: DEFINITIONS.keys).destroy_all
    DEFINITIONS.each do |slug, finder|
      technology = find_or_create_by!(slug: slug)
      jobs_scope = finder.call
      jobs_scope.where.not(id: technology.jobs).find_each do |job|
        job.technologies << technology
      end
      technology.job_technologies.joins(:job).where.not(jobs: { id: jobs_scope }).destroy_all
    end
  end

  def to_param
    slug
  end
end
