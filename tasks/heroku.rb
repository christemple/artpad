desc 'Push to Heroku'
task :heroku do
  fail 'Failed to push to Heroku' unless `git push heroku master -f`
end
