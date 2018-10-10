class Technology < ActiveRecord::Base
  has_many :job_technologies, dependent: :destroy
  has_many :jobs, through: :job_technologies

  DEFINITIONS = {
    android: {
      label: 'Android',
      finder: -> { Job.matching_words(%w(android)) }
    },
    clojure: {
      label: 'Clojure',
      finder: -> { Job.matching_words(%w(clojure)) }
    },
    cplusplus: {
      label: 'C++',
      finder: -> { Job.matching_text(%w(c\+\+)) }
    },
    csharp: {
      label: 'C#',
      finder: -> { Job.matching_text(%w(c#)) }
    },
    django: {
      label: 'Django',
      finder: -> { Job.matching_words(%w(django)) }
    },
    elixir: {
      label: 'Elixir',
      finder: -> { Job.matching_words(%w(elixir)) }
    },
    elm: {
      label: 'Elm',
      finder: -> { Job.matching_words(%w(elm)) }
    },
    ios: {
      label: 'iOS',
      finder: -> { Job.matching_words(%w(ios)) }
    },
    java: {
      label: 'Java',
      finder: -> { Job.matching_words(%w(java)) }
    },
    javascript: {
      label: 'JavaScript',
      finder: -> { Job.matching_words(%w(javascript)) }
    },
    kotlin: {
      label: 'Kotlin',
      finder: -> { Job.matching_words(%w(kotlin)) }
    },
    php: {
      label: 'PHP',
      finder: -> { Job.matching_words(%w(php)) }
    },
    python: {
      label: 'Python',
      finder: -> { Job.matching_words(%w(python django)) }
    },
    rails: {
      label: 'Ruby on Rails',
      finder: -> { Job.matching_words(%w(rails)) }
    },
    ruby: {
      label: 'Ruby',
      finder: -> { Job.matching_words(%w(ruby rails)) }
    },
    rust: {
      label: 'Rust',
      finder: -> { Job.matching_words(%w(rust)) }
    },
    scala: {
      label: 'Scala',
      finder: -> { Job.matching_words(%w(scala)) }
    },
    swift: {
      label: 'Swift',
      finder: -> { Job.matching_words(%w(swift)) }
    }
  }

  def self.populate!
    Technology.where.not(slug: DEFINITIONS.keys).destroy_all
    DEFINITIONS.each do |slug, attributes|
      technology = find_or_create_by!(slug: slug, name: attributes.fetch(:label))
      jobs_scope = attributes.fetch(:finder).call
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
