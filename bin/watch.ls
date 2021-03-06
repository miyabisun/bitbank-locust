require! {
  fs, path
  child_process: {spawn}
  \prelude-ls : P
}
rdirs = (dir, results = []) ->
  results.push dir
  cdirs = fs.readdir-sync "#__dirname/../#dir"
  |> P.reject (is /^\./)
  |> P.filter ("#__dirname/../#dir/" +) >> fs.stat-sync >> (.is-directory!)
  |> P.each (-> "#dir/#it") >> rdirs _, results
  return results
output = (command) -> new Promise (resolve) ->
  console.info "> #{command}"
  command.split " " |> ->
    spawn it.0, it.slice 1
      ..stdout.pipe process.stdout
      ..stderr.pipe process.stderr
      ..on \close -> resolve yes
test = (file) ->> await output "mocha --colors #{file}"
hr = -> console.info "---------- ---------- ----------"

<[classes functions modules]>
|> P.map rdirs |> P.flatten |> (++ [""])
|> P.each (dir) ->
  tasks = new Set!
  ["#{dir or \.}", "test/#{dir}"].for-each fs.watch _, (type, file) ->>
    return if type isnt \change
    return if file isnt /\.ls$/
    return if tasks.has file
    tasks.add file
    try
      if dir
        await test "test/#{dir}/#{file}"
      else
        await test "test/#{file}"
      hr!
    tasks.delete file

console.info "Get Ready."
hr!
