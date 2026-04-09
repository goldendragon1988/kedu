Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  resources :alphabets, only: [ :index, :show ]

  get "/math", to: "math#index"
  get "/puzzles", to: "puzzles#index"

  namespace :puzzles do
    get "/word_search/download", to: "word_search#download"
    get "/word_search/pdf", to: "word_search#pdf"

    get "/crossword/download", to: "crossword#download"
    get "/crossword/pdf", to: "crossword#pdf"

    get "/sudoku/download", to: "sudoku#download"
    get "/sudoku/pdf", to: "sudoku#pdf"
  end

  namespace :math do
    # compare
    get "/compare_numbers/download", to: "compare_numbers#download"
    get "/compare_numbers/pdf", to: "compare_numbers#pdf"

    # subtraction
    get "/subtraction/download", to: "subtraction#download"
    get "/subtraction/pdf", to: "subtraction#pdf"

    # addition
    get "/addition/download", to: "addition#download"
    get "/addition/pdf", to: "addition#pdf"

    # multiplication
    get "/multiplication/download", to: "multiplication#download"
    get "/multiplication/pdf", to: "multiplication#pdf"

    # division
    get "/division/download", to: "division#download"
    get "/division/pdf", to: "division#pdf"

    # modulo
    get "/modulo/download", to: "modulo#download"
    get "/modulo/pdf", to: "modulo#pdf"

    # missing number exercises
    get "/missing_random/download", to: "missing_random#download"
    get "/missing_random/pdf", to: "missing_random#pdf"

    get "/missing_addition/download", to: "missing_addition#download"
    get "/missing_addition/pdf", to: "missing_addition#pdf"

    get "/missing_subtraction/download", to: "missing_subtraction#download"
    get "/missing_subtraction/pdf", to: "missing_subtraction#pdf"

    get "/missing_multiplication/download", to: "missing_multiplication#download"
    get "/missing_multiplication/pdf", to: "missing_multiplication#pdf"

    get "/missing_division/download", to: "missing_division#download"
    get "/missing_division/pdf", to: "missing_division#pdf"
  end

  # Defines the root path route ("/")
  root "welcome#index"
end
