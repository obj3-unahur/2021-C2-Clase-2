module Volador
  attr_reader :energia, :esfuerzo_volar

  def volar(distancia)
    puts "Volando #{distancia} mts"
    @energia  -= (distancia * @esfuerzo_volar)
  end

  def recuperar(horas)
    puts "Recuperar como Volador #{horas} hs"
    @energia += (horas * 5)
  end
end

module Corredor
  attr_reader :energia, :esfuerzo_correr

  def correr(distancia)
    puts "Corriendo #{distancia} mts"
    @energia -= (distancia * @esfuerzo_correr)
  end

  def recuperar(horas)
    puts "Recuperar como Corredor #{horas} hs"
    @energia += (horas * 20)
  end
end

class Pegaso
  include Corredor
  alias_method :recuperar_como_corredor, :recuperar
  include Volador
  alias_method :recuperar_como_volador, :recuperar

  def initialize(energia, esfuerzo_volar, esfuerzo_correr)
    @energia = energia
    @esfuerzo_correr = esfuerzo_correr
    @esfuerzo_volar = esfuerzo_volar
  end

  def recuperar(horas)
    recuperar_como_corredor horas
    recuperar_como_volador horas
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

class Dragon
  include Corredor
  include Volador

  def initialize(e, c, v)
    @energia = e
    @esfuerzo_correr = c
    @esfuerzo_volar = v
  end
end

class Centauro
  include Corredor

  def initialize(energia)
    @energia = energia
    @esfuerzo_correr = 10
  end
end

class Fenix
  include Volador

  def volar(distancia)
    super
    @esfuerzo_volar += 1
  end
end

class Amo
  attr_reader :pegasos, :accion

  def initialize(pegasos, &accion)
    @pegasos = pegasos
    @accion = accion
  end

  def recuperar(horas)
    @accion.call(@pegasos, horas)
    # accion.recuperar(@pegasos, horas)
  end

  def self.bondadoso(pegasos)
    Amo.new(pegasos) do |pegasos, horas|
      pegasos.each do |pegaso|
        pegaso.recuperar horas
      end
    end
  end

  def self.castigador(pegasos)
    Amo.new(pegasos) do |pegasos, horas|
      pegasos.each {|pegaso|
        pegaso.recuperar(horas / 2)
      }
    end
  end
end

# module Accion
#   def recuperar(pegasos, horas)
#     NotImplementedError.new
#   end
# end

# class Bondadoso
#   # include Accion
#
#   def recuperar(pegasos, horas)
#     pegasos.each do |pegaso|
#       pegaso.recuperar horas
#     end
#   end
# end
#
# class Castigador
#   def recuperar(pegasos, horas)
#     pegasos.each do |pegaso|
#       pegaso.recuperar(horas / 2)
#     end
#   end
# end
