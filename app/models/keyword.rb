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
      perl:           -> { Job.matching_words(%w(perl)) },
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
      amsterdam:       -> { Job.matching_words(%w(Amsterdam)) },
      'ann-arbor':     -> { Job.matching_words(['Ann Arbor']) },
      atlanta:         -> { Job.matching_words(%w(Atlanta)) },
      auckland:        -> { Job.matching_words(%w(Auckland)) },
      austin:          -> { Job.matching_words(%w(Austin)) },
      bangalore:       -> { Job.matching_words(%w(Bangalore Bengaluru)) },
      bangkok:         -> { Job.matching_words(%w(Bangkok)) },
      barcelona:       -> { Job.matching_words(%w(Barcelona)) },
      beijing:         -> { Job.matching_words(%w(Beijing)) },
      berkeley:        -> { Job.matching_words(%w(Berkeley)) },
      berlin:          -> { Job.matching_words(%w(Berlin)) },
      boston:          -> { Job.matching_words(%w(Boston)) },
      boulder:         -> { Job.matching_words(%w(Boulder)) },
      braga:           -> { Job.matching_words(%w(Braga)) },
      bratislava:      -> { Job.matching_words(%w(Bratislava)) },
      brooklyn:        -> { Job.matching_words(%w(Brooklyn)) },
      budapest:        -> { Job.matching_words(%w(Budapest)) },
      burlingame:      -> { Job.matching_words(%w(Burlingame)) },
      'cambridge-ma':  -> { Job.matching_text('\yCambridge\y(?!(,\s|\s)uk)') },
      'cambridge-uk':  -> { Job.matching_words(['Cambridge UK', 'Cambridge, UK', 'Cambridgeshire']) },
      'cape-town':     -> { Job.matching_words(['Cape Town']) },
      charlotte:       -> { Job.matching_words(%w(Charlotte)) },
      chennai:         -> { Job.matching_words(%w(Chennai)) },
      chicago:         -> { Job.matching_words(%w(Chicago)) },
      cologne:         -> { Job.matching_words(%w(Cologne Köln)) },
      cupertino:       -> { Job.matching_words(%w(Cupertino)) },
      dallas:          -> { Job.matching_words(%w(Dallas)) },
      dc:              -> { Job.matching_words(%w(DC D\.C\.)) },
      denver:          -> { Job.matching_words(%w(Denver)) },
      detroit:         -> { Job.matching_words(%w(Detroit)) },
      dubai:           -> { Job.matching_words(%w(Dubai)) },
      dublin:          -> { Job.matching_words(%w(Dublin)) },
      durham:          -> { Job.matching_words(%w(Durham)) },
      edinburgh:       -> { Job.matching_words(%w(Edinburgh)) },
      eindhoven:       -> { Job.matching_words(%w(Eindhoven)) },
      geneve:          -> { Job.matching_words(%w(Geneve)) },
      guadalajara:     -> { Job.matching_words(%w(Guadalajara)) },
      'hong-kong':     -> { Job.matching_words(['Hong Kong']) },
      houston:         -> { Job.matching_words(%w(Houston)) },
      hyderabad:       -> { Job.matching_words(%w(Hyderabad)) },
      irvine:          -> { Job.matching_words(%w(Irvine)) },
      lausanne:        -> { Job.matching_words(%w(Lausanne)) },
      lincoln:         -> { Job.matching_words(%w(Lincoln)) },
      lisbon:          -> { Job.matching_words(%w(Lisbon)) },
      la:              -> { Job.matching_text_sensitive('\yLA\y').merge(Job.not_matching_words(['New Orleans, LA']))
                              .or(Job.matching_words(['Los Angeles', 'Santa Monica', 'Pasadena', 'Venice', 'Culver City'])) },
      london:          -> { Job.matching_words(%w(London)) },
      'los-gatos':     -> { Job.matching_words(['Los Gatos']) },
      madrid:          -> { Job.matching_words(%w(Madrid)) },
      manila:          -> { Job.matching_words(%w(Manila)) },
      'melbourne-au':  -> { Job.matching_words(['Melbourne, AU', 'Melbourne, Australia']) },
      'melbourne-fl':  -> { Job.matching_words(%w(Melbourne))
                              .merge(Job.not_matching_words(['Melbourne, AU', 'Melbourne, Australia'])) },
      'menlo-park':    -> { Job.matching_words(['Menlo Park']) },
      'mexico-city':   -> { Job.matching_words(['Mexico City']) },
      'mountain-view': -> { Job.matching_words(['Mountain View']) },
      montreal:        -> { Job.matching_words(%w(Montreal)) },
      munich:          -> { Job.matching_words(%w(Munich)) },
      nyc:             -> { Job.matching_words(['New York', 'NYC']) },
      oakland:         -> { Job.matching_words(%w(Oakland)) },
      oslo:            -> { Job.matching_words(%w(Oslo)) },
      oxford:          -> { Job.matching_words(%w(Oxford)) },
      'palo-alto':     -> { Job.matching_words(['Palo Alto']) },
      paris:           -> { Job.matching_words(%w(Paris)) },
      'phoenix-az':    -> { Job.matching_words(['Phoenix, AZ', 'Phoenix, Arizona']) },
      philadelphia:    -> { Job.matching_words(%w(Philadelphia)) },
      pittsburgh:      -> { Job.matching_words(%w(Pittsburgh)) },
      portland:        -> { Job.matching_words(%w(Portland)) },
      prague:          -> { Job.matching_words(%w(Prague)) },
      princeton:       -> { Job.matching_words(%w(Princeton)) },
      pune:            -> { Job.matching_words(%w(Pune)) },
      raleigh:         -> { Job.matching_words(%w(Raleigh)) },
      'redwood-city':  -> { Job.matching_words(['Redwood City']) },
      remote:          -> { Job.matching_words(%w(Remote)).merge(Job.not_matching_words(['No Remote']))
                              .merge(Job.matching_text('remote(?<!<\/p>.*)')) },
      'san-diego':     -> { Job.matching_words(['San Diego']) },
      'san-mateo':     -> { Job.matching_words(['San Mateo']) },
      'san-jose':      -> { Job.matching_words(['San Jose']) },
      'san-ramon':     -> { Job.matching_words(['San Ramon']) },
      'sao-paulo':     -> { Job.matching_words(['São Paulo', 'Sao Paulo']) },
      sf:              -> { Job.matching_words(['San Francisco', 'SF']) },
      seattle:         -> { Job.matching_words(%w(Seattle)) },
      seoul:           -> { Job.matching_words(%w(Seoul)) },
      shanghai:        -> { Job.matching_words(%w(shanghai)) },
      singapore:       -> { Job.matching_words(%w(Singapore)) },
      sunnyvale:       -> { Job.matching_words(%w(Sunnyvale)) },
      sydney:          -> { Job.matching_words(%w(Sydney)) },
      tampa:           -> { Job.matching_words(%w(Tampa)) },
      tokyo:           -> { Job.matching_words(%w(Tokyo)) },
      toronto:         -> { Job.matching_words(%w(Toronto)) },
      trondheim:       -> { Job.matching_words(%w(Trondheim)) },
      tucson:          -> { Job.matching_words(%w(Tucson)) },
      vancouver:       -> { Job.matching_words(%w(Vancouver)) },
      warsaw:          -> { Job.matching_words(%w(Warsaw)) },
      wellington:      -> { Job.matching_words(%w(Wellington)) },
      zurich:          -> { Job.matching_words(%w(Zurich)) }
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
