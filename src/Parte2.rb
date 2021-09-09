class Corredor
  attr_reader :energia, :esfuerzo_correr

  def initialize(energia, esfuerzo_correr)
    @energia = energia
    @esfuerzo_correr = esfuerzo_correr
  end

  def correr(distancia)
    puts "Corriendo #{distancia} metros"
    @energia -= (distancia * @esfuerzo_correr)
  end
end

class Centauro < Corredor
  def initialize(energia)
    super energia, 10
  end
end

class Pegaso < Corredor
  attr_reader :esfuerzo_volar

  def initialize(energia, esfuerzo_volar, esfuerzo_correr)
    super(energia, esfuerzo_correr)
    @esfuerzo_volar = esfuerzo_volar
  end

  def volar(distancia)
    puts "Volando #{distancia} metros"
    @energia -= (distancia * @esfuerzo_volar)
  end
end

class Unicornio < Pegaso
  attr_accessor :cuerno

  def initialize(energia: 100, esfuerzo_volar: 5, esfuerzo_correr: 1, cuerno:)
    super(energia, esfuerzo_volar, esfuerzo_correr)
    @cuerno = cuerno
  end

  def esfuerzo_volar
    @cuerno.esfuerzo_volar(@esfuerzo_volar)
  end
end

class Cuerno
  def initialize(modificador_volar)
    @modificador_volar = modificador_volar
  end

  def esfuerzo_volar(base)
    base * @modificador_volar
  end
end
