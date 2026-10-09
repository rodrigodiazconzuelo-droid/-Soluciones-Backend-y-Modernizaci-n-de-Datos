"""
===========================================================================
Motor Backend para WhatsApp Cloud API
===========================================================================
Este servidor FastAPI recibe los mensajes entrantes de los clientes en tiempo 
real y estructura la respuesta automática. Diseñado para ser escalable y de 
baja latencia (High Performance).
"""

from fastapi import FastAPI, Request, HTTPException
from pydantic import BaseModel
import uvicorn

app = FastAPI(title="Motor de Automatización WhatsApp", version="1.0")

# Tokens de seguridad y verificación (Variables de Entorno simuladas)
VERIFY_TOKEN = "MI_TOKEN_SEGURO_123"

@app.get("/webhook")
async def verificar_webhook(hub_mode: str, hub_verify_token: str, hub_challenge: int):
    """
    Endpoint obligatorio de Meta/Facebook para verificar la conexión de la API.
    """
    if hub_mode == "subscribe" and hub_verify_token == VERIFY_TOKEN:
        return hub_challenge
    raise HTTPException(status_code=403, detail="Token de verificación inválido")

@app.post("/webhook")
async def recibir_mensaje_whatsapp(request: Request):
    """
    Recibe la carga útil (payload) cuando un cliente envía un mensaje al comercio.
    Aquí se conecta la lógica de Inteligencia Artificial o flujos de respuestas.
    """
    body = await request.json()
    
    try:
        # Extracción segura de los datos del cliente
        numero_cliente = body['entry'][0]['changes'][0]['value']['messages'][0]['from']
        mensaje_texto = body['entry'][0]['changes'][0]['value']['messages'][0]['text']['body']
        
        # Simulación de enrutamiento inteligente
        if "precio" in mensaje_texto.lower():
            respuesta = "Nuestros precios actualizados están en nuestro catálogo web."
        else:
            respuesta = "¡Hola! En un momento un asesor te atenderá."
            
        print(f"Respondiendo a {numero_cliente}: {respuesta}")
        
        # Se retorna 200 OK inmediatamente para que WhatsApp no reintente el envío
        return {"status": "success", "message": "Procesado correctamente"}

    except KeyError:
        # Manejo de errores si el JSON no tiene el formato esperado
        return {"status": "ignored", "message": "Evento no es un mensaje de texto"}

if __name__ == "__main__":
    # Servidor local para pruebas
    uvicorn.run(app, host="0.0.0.0", port=8000)
