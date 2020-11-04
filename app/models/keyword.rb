class Keyword < ActiveRecord::Base
  has_many :comment_keywords, dependent: :destroy
  has_many :comments, through: :comment_keywords

  scope :technology, -> { where(kind: 'technology') }
  scope :location, -> { where(kind: 'location') }

  FINDERS = {
    technology: {
      android:        -> { Comment.matching_words(%w(android)) },
      angular:        -> { Comment.matching_words(%w(angular angularjs)) },
      c:              -> { Comment.matching_text_sensitive('\sC(,\s|\.\s|/)')
                             .merge(Comment.matching_text_sensitive('(?<!bj)(?<!bjective)\sC(,\s|\.\s|/)')) },
      clojure:        -> { Comment.matching_words(%w(clojure)) },
      cplusplus:      -> { Comment.matching_text(%w(c\+\+)) },
      csharp:         -> { Comment.matching_text(%w(c#)) },
      django:         -> { Comment.matching_words(%w(django)) },
      elixir:         -> { Comment.matching_words(%w(elixir)) },
      elm:            -> { Comment.matching_words(%w(elm)) },
      ember:          -> { Comment.matching_words(%w(ember emberjs)) },
      go:             -> { Comment.matching_words(%w(golang)).or(Comment.matching_text_sensitive('\yGo\y')) },
      ios:            -> { Comment.matching_words(%w(ios)) },
      java:           -> { Comment.matching_words(%w(java)) },
      javascript:     -> { Comment.matching_words(%w(javascript)) },
      kotlin:         -> { Comment.matching_words(%w(kotlin)) },
      kubernetes:     -> { Comment.matching_words(%w(kubernetes k8s)) },
      node:           -> { Comment.matching_words(%w(node nodejs)) },
      perl:           -> { Comment.matching_words(%w(perl)) },
      php:            -> { Comment.matching_words(%w(php)) },
      python:         -> { Comment.matching_words(%w(python django)) },
      rails:          -> { Comment.matching_words(%w(rails ror)) },
      react:          -> { Comment.matching_text('\yreact\y(?!(-|\s)native)').or(Comment.matching_words(%w(reactjs))) },
      'react-native': -> { Comment.matching_words(%w(react-native)).or(Comment.matching_text('react native')) },
      ruby:           -> { Comment.matching_words(%w(ruby rails ror)) },
      rust:           -> { Comment.matching_words(%w(rust)) },
      scala:          -> { Comment.matching_words(%w(scala)) },
      swift:          -> { Comment.matching_words(%w(swift)) },
      vue:            -> { Comment.matching_words(%w(vue vuejs)) }
    },
    location:   {
      amsterdam:       -> { Comment.matching_words(%w(Amsterdam)) },
      'ann-arbor':     -> { Comment.matching_words(['Ann Arbor']) },
      atlanta:         -> { Comment.matching_words(%w(Atlanta)) },
      auckland:        -> { Comment.matching_words(%w(Auckland)) },
      austin:          -> { Comment.matching_words(%w(Austin)) },
      bangalore:       -> { Comment.matching_words(%w(Bangalore Bengaluru)) },
      bangkok:         -> { Comment.matching_words(%w(Bangkok)) },
      barcelona:       -> { Comment.matching_words(%w(Barcelona)) },
      beijing:         -> { Comment.matching_words(%w(Beijing)) },
      berkeley:        -> { Comment.matching_words(%w(Berkeley)) },
      berlin:          -> { Comment.matching_words(%w(Berlin)) },
      bogota:          -> { Comment.matching_words(%w(Bogotá)) },
      boston:          -> { Comment.matching_words(%w(Boston)) },
      boulder:         -> { Comment.matching_words(%w(Boulder)) },
      braga:           -> { Comment.matching_words(%w(Braga)) },
      bratislava:      -> { Comment.matching_words(%w(Bratislava)) },
      brooklyn:        -> { Comment.matching_words(%w(Brooklyn)) },
      budapest:        -> { Comment.matching_words(%w(Budapest)) },
      burlingame:      -> { Comment.matching_words(%w(Burlingame)) },
      'cambridge-ma':  -> { Comment.matching_text('\yCambridge\y(?!(,\s|\s)uk)') },
      'cambridge-uk':  -> { Comment.matching_words(['Cambridge UK', 'Cambridge, UK', 'Cambridgeshire']) },
      'cape-town':     -> { Comment.matching_words(['Cape Town']) },
      charlotte:       -> { Comment.matching_words(%w(Charlotte)) },
      chennai:         -> { Comment.matching_words(%w(Chennai)) },
      chicago:         -> { Comment.matching_words(%w(Chicago)) },
      cologne:         -> { Comment.matching_words(%w(Cologne Köln)) },
      cupertino:       -> { Comment.matching_words(%w(Cupertino)) },
      dallas:          -> { Comment.matching_words(%w(Dallas)) },
      dc:              -> { Comment.matching_words(%w(DC D\.C\.)) },
      denver:          -> { Comment.matching_words(%w(Denver)) },
      detroit:         -> { Comment.matching_words(%w(Detroit)) },
      dubai:           -> { Comment.matching_words(%w(Dubai)) },
      dublin:          -> { Comment.matching_words(%w(Dublin)) },
      durham:          -> { Comment.matching_words(%w(Durham)) },
      edinburgh:       -> { Comment.matching_words(%w(Edinburgh)) },
      eindhoven:       -> { Comment.matching_words(%w(Eindhoven)) },
      emeryville:      -> { Comment.matching_words(%w(Emeryville)) },
      geneve:          -> { Comment.matching_words(%w(Geneve)) },
      guadalajara:     -> { Comment.matching_words(%w(Guadalajara)) },
      'hong-kong':     -> { Comment.matching_words(['Hong Kong']) },
      hangzhou:         -> { Comment.matching_words(%w(Hangzhou)) },
      houston:         -> { Comment.matching_words(%w(Houston)) },
      hyderabad:       -> { Comment.matching_words(%w(Hyderabad)) },
      irvine:          -> { Comment.matching_words(%w(Irvine)) },
      lausanne:        -> { Comment.matching_words(%w(Lausanne)) },
      'kansas-city':   -> { Comment.matching_words(['Kansas City']) },
      knoxville:       -> { Comment.matching_words(%w(Knoxville)) },
      lincoln:         -> { Comment.matching_words(%w(Lincoln)) },
      lisbon:          -> { Comment.matching_words(%w(Lisbon)) },
      la:              -> { Comment.matching_text_sensitive('\yLA\y').merge(Comment.not_matching_words(['New Orleans, LA']))
                              .or(Comment.matching_words(['Los Angeles', 'Santa Monica', 'Pasadena', 'Venice', 'Culver City'])) },
      london:          -> { Comment.matching_words(%w(London)) },
      'los-gatos':     -> { Comment.matching_words(['Los Gatos']) },
      madrid:          -> { Comment.matching_words(%w(Madrid)) },
      manila:          -> { Comment.matching_words(%w(Manila)) },
      'melbourne-au':  -> { Comment.matching_words(['Melbourne, AU', 'Melbourne, Australia']) },
      'melbourne-fl':  -> { Comment.matching_words(%w(Melbourne))
                              .merge(Comment.not_matching_words(['Melbourne, AU', 'Melbourne, Australia'])) },
      'menlo-park':    -> { Comment.matching_words(['Menlo Park']) },
      'mexico-city':   -> { Comment.matching_words(['Mexico City']) },
      'mountain-view': -> { Comment.matching_words(['Mountain View']) },
      montreal:        -> { Comment.matching_words(%w(Montreal)) },
      munich:          -> { Comment.matching_words(%w(Munich)) },
      nyc:             -> { Comment.matching_words(['New York', 'NYC']) },
      oakland:         -> { Comment.matching_words(%w(Oakland)) },
      oslo:            -> { Comment.matching_words(%w(Oslo)) },
      oxford:          -> { Comment.matching_words(%w(Oxford)) },
      'palo-alto':     -> { Comment.matching_words(['Palo Alto']) },
      paris:           -> { Comment.matching_words(%w(Paris)) },
      'phoenix-az':    -> { Comment.matching_words(['Phoenix, AZ', 'Phoenix, Arizona']) },
      philadelphia:    -> { Comment.matching_words(%w(Philadelphia)) },
      pittsburgh:      -> { Comment.matching_words(%w(Pittsburgh)) },
      portland:        -> { Comment.matching_words(%w(Portland)) },
      prague:          -> { Comment.matching_words(%w(Prague)) },
      princeton:       -> { Comment.matching_words(%w(Princeton)) },
      pune:            -> { Comment.matching_words(%w(Pune)) },
      raleigh:         -> { Comment.matching_words(%w(Raleigh)) },
      'redwood-city':  -> { Comment.matching_words(['Redwood City']) },
      remote:          -> { Comment.matching_words(%w(Remote)).merge(Comment.not_matching_words(['No Remote']))
                              .merge(Comment.matching_text('remote(?<!<\/p>.*)')) },
      'salt-lake-city':-> { Comment.matching_words(['Salt Lake City']) },
      'san-diego':     -> { Comment.matching_words(['San Diego']) },
      'san-mateo':     -> { Comment.matching_words(['San Mateo']) },
      'san-jose':      -> { Comment.matching_words(['San Jose']) },
      'san-ramon':     -> { Comment.matching_words(['San Ramon']) },
      'sao-paulo':     -> { Comment.matching_words(['São Paulo', 'Sao Paulo']) },
      sf:              -> { Comment.matching_words(['San Francisco', 'SF']) },
      seattle:         -> { Comment.matching_words(%w(Seattle)) },
      seoul:           -> { Comment.matching_words(%w(Seoul)) },
      shanghai:        -> { Comment.matching_words(%w(Shanghai)) },
      shenzhen:        -> { Comment.matching_words(%w(Shenzhen)) },
      singapore:       -> { Comment.matching_words(%w(Singapore)) },
      sunnyvale:       -> { Comment.matching_words(%w(Sunnyvale)) },
      sydney:          -> { Comment.matching_words(%w(Sydney)) },
      tampa:           -> { Comment.matching_words(%w(Tampa)) },
      tokyo:           -> { Comment.matching_words(%w(Tokyo)) },
      toronto:         -> { Comment.matching_words(%w(Toronto)) },
      trondheim:       -> { Comment.matching_words(%w(Trondheim)) },
      tucson:          -> { Comment.matching_words(%w(Tucson)) },
      vancouver:       -> { Comment.matching_words(%w(Vancouver)) },
      warsaw:          -> { Comment.matching_words(%w(Warsaw)) },
      wellington:      -> { Comment.matching_words(%w(Wellington)) },
      zurich:          -> { Comment.matching_words(%w(Zurich)) }
    }
  }.freeze

  def self.populate!
    FINDERS.each do |kind, finders|
      Keyword.where(kind: kind).where.not(slug: finders.keys).destroy_all
      finders.each do |slug, finder|
        keyword = find_or_create_by!(slug: slug, kind: kind)
        comments_scope = finder.call
        comments_scope.where.not(id: keyword.comments).find_each do |comment|
          comment.keywords << keyword
        end
        keyword.comment_keywords.joins(:comment).where.not(comments: { id: comments_scope }).destroy_all
      end
    end
  end

  def to_param
    slug
  end
end
