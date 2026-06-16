$basedir = Split-Path -Parent $MyInvocation.MyCommand.Definition
& "$basedir\..\node_modules\.bin\opencode-marketplace.cmd" $args
exit $LASTEXITCODE
