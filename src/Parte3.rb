module Volador
  attr_reader :energia, :esfuerzo_volar

  def volar(distancia)
    puts "Volando #{distancia} metros"
    @energia -= (distancia * @esfuerzo_volar)
  end
end

module Corredor
  attr_reader :energia, :esfuerzo_correr

  def correr(distancia)
    puts "Corriendo #{distancia} metros"
    @energia -= (distancia * @esfuerzo_correr)
  end
end

class Fenix
  include Volador

  def initialize
    @energia = 1000
    @esfuerzo_volar = 0
  end

  def volar(distancia)
    super
    @esfuerzo_volar += 1
  end
end

class Centauro
  include Corredor

  def initialize(energia)
    @energia = energia
    @esfuerzo_correr = 10
  end
end

class Pegaso
  include Corredor
  include Volador

  def initialize(energia, esfuerzo_volar, esfuerzo_correr)
    @energia = energia
    @esfuerzo_volar = esfuerzo_volar
    @esfuerzo_correr = esfuerzo_correr
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
