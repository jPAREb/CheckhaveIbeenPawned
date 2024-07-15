function Correo-Comprometido
{
    param(
        [String] $correo
    )
    # Definir l'URL de l'API de Have I Been Pwned
    $baseUrl = "https://haveibeenpwned.com/api/v3/breachedaccount/"

    

    # Definir la clau de l'API
    $apiKey = "api_key"

    # Crear la capçalera amb la clau de l'API
    $headers = @{
        "hibp-api-key" = $apiKey
    }
    try{

        # Fer la crida a l'API amb la capçalera
        $response = Invoke-RestMethod -Uri ($baseUrl + $correo) -Method Get -Headers $headers -ErrorAction SilentlyContinue
        Write-Host "Filtraciones: "
        # Comprovar si la adreça de correu electrònic ha estat compromesa
        if ($response) {
           foreach ($breach in $response) {
                # Fer una petició addicional per obtenir els detalls de la filtració
                $breachDetails = Invoke-RestMethod -Uri ("https://haveibeenpwned.com/api/v3/breach/" + $breach.Name) -Method Get -Headers $headers
        
                # Mostrar el nom de la base de dades i la data de la filtració
                Write-Host "•	$($breachDetails.Name) ($($breachDetails.BreachDate))"
            }
            Write-Host ""
            Write-Host ""
        } else {
            #Write-Host "El correo $email no está comprometido."
        }
    }
    catch{
        Write-Host "El correo $email no está comprometido."
    }
}
