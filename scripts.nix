{s}: 
{
  ghcidScript = s "dev" "ghcid --command 'cabal new-repl lib:haskell-road' --allow-eval --warnings";
  testScript = s "test" "cabal run test:haskell-road-tests";
  hoogleScript = s "hgl" "hoogle serve";
}
