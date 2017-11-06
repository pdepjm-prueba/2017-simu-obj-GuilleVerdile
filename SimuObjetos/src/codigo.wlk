// Parcial Los Glaciares

class Tempano {
	
	var peso
	var tipo 
	
	constructor(_peso, _tipo){
		peso = _peso
		tipo = _tipo
	}
	method peso(){
		return peso
	}
	method parte_visible(){
		return peso*0.15
	}
	method tipo(){
		return tipo
	}
	method peso(_peso){
		peso = _peso
	}
	method tipo(_tipo){
		tipo = _tipo
	}

	method esGrande (){
		return peso > 500
	}

	method seVeAzul (){
		tipo.seVeAzul(self)
	}

	method cuantoEnfria(){
		tipo.cuantoEnfria(self)
	}
	
	method modificarTempano(){
		self.perderPeso(1)
		if(self.esCompacto() && !self.esGrande())
		{
			self.tipo(new Aireado())
		}
	}
	
	method perderPeso(perdida){
		peso = peso - perdida
	}
	
	method esCompacto(){
		return tipo.esCompacto()
	}
}

class Compacto{
	
	method seVeAzul(tempano){
		return tempano.parte_visible() > 100
	}
	method cuantoEnfria(tempano){
		return tempano.peso()*0.01
	}
	method esCompacto(){
		return true  
	}
}

class Aireado{
	
	method seVeAzul(tempano){
		return false 
	}
	method cuantoEnfria(tempano){
		return 0.5
	}
	method esCompacto(){
		return false  
	}
}

class Masa_de_Agua{
	
	var tempanos_flotando = []
	const temperatura_ambiente = 20
	
	constructor(temp_flot){
		tempanos_flotando = temp_flot
	}
	
	method tempanos_flotando(){
		return tempanos_flotando
	}
	
	method esAtractiva(){
		return tempanos_flotando.size() > 5 && tempanos_flotando.forEach({tempano => tempano.esGrande() || tempano.seVeAzul()})
	}
	
	method temperatura(){
		return temperatura_ambiente - tempanos_flotando.sum({tempano => tempano.cuantoEnfria()})
	}
	
	method leCaeTempano(tempano){
		tempanos_flotando.add(tempano)
	}
	
	method cantidadTempanosGrandes(){
		return tempanos_flotando.filter({tempano => tempano.esGrande()}).size()
	}
	
	method puedeNavegarse(embarcacion) 
	
	method sufrirEfectoNavegacion(){
		tempanos_flotando.forEach({tempano => tempano.modificarTempano()})
	}
}

class Lago inherits Masa_de_Agua{
	override method puedeNavegarse(embarcacion){
		if(self.cantidadTempanosGrandes() > 20){
			return embarcacion.tamanio() < 10 && self.temperatura() < 0 
		}
		return self.temperatura() < 0 
	}
}

class Rio inherits Masa_de_Agua{
	
	var velocidadBaseAgua
	
	override method temperatura(){
		return super() + self.velocidadAgua()
	}
	method velocidadAgua() {
		return velocidadBaseAgua - self.cantidadTempanosGrandes()
	}
	
	override method puedeNavegarse(embarcacion){
		return self.velocidadAgua() < embarcacion.fuerza_motor()
	}
}

class Glaciar{
	
	var masa
	var desembocadura
	const temperatura = 1
	
	constructor (_masa,_desembocadura){
		masa = _masa 
	 	desembocadura = _desembocadura
	}
	method pesoTempanoDesprendimiento(){
		
		return 0.000001*masa*desembocadura.temperatura()
	}
	
	method desprendimiento(){
		var tempano = new Tempano(self.pesoTempanoDesprendimiento(),new Compacto())
		self.perderMasa(tempano.peso())
		desembocadura.leCaeUnTempano(tempano)
	}
	method perderMasa(peso) {
		masa = masa - peso 
	}
	method leCaeTempano(tempano){
		masa = masa + tempano.peso()
		
	}

}

class Embarcacion{
	var tamanio
	var fuerza_motor
	
	constructor(_tamanio,_fuerza_motor){
		tamanio = _tamanio
		fuerza_motor = _fuerza_motor
	}
	
	method tamanio(){
		return tamanio
	}
	method fuerza_motor(){
		return fuerza_motor
	}
	
	method puedeRealizarViaje(masa_de_Agua){
		return masa_de_Agua.puedeNavegarse(self)
	}
	
	method navegar(masa_de_Agua){
		if(self.puedeRealizarViaje(masa_de_Agua)){
			masa_de_Agua.sufrirEfectoNavegacion()
		}
	}	
}















