module Tradutor
    #torna um requisito a gem do Google
    require "google/cloud/translate/v2"

    # Classe raiz da aplicação
    class Tradutor
        # váriavel de classe que guarda a Key fornecida pelo Google #
        @@key = "API_KEY"

        # Método responsável por pergundar ao usuário o texto e o idioma #
        def initialize 

            puts "Olá, qual texto gostaria de traduzir? "
            text = gets.chomp

            puts "Para qual idioma será convertido? [pt-br, en, fr, de...]: "
            language = gets.chomp

            # Chamada ao método responsável pela conexão a API e tradução #
            translate(text, language)
        end

        private
        def translate text, language
            
            # Instância da API e fornecimento da key de autorização #
            translate = Google::Cloud::Translate::V2.new(
                key: @@key
            )

            # Chamada ao método translate e envio do texto e o idioma como parametros #
            translation = translate.translate(text, to: language)
            puts translation.text

            # Chamada ao método de log #
            log(text, translation.text)
        end

        private
        # Método responsável por escrever no arquivo de log #
        def log text, translated

            # Instância do metódo TIME para extrair a hora atual do servidor #
            time = Time.new

            # Realiza a escrita no arquivo de log e através do parametro 'a' ele adiciona as novas linhas sem apagar as anteriores #
            File.open('log.txt', 'a') do |line|                
                line.puts "Texto: #{text} || Tradução: #{translated} || " + time.strftime('%d-%m-%y_%H:%M')
            end
        end
    end
end

# Abre a instância do módulo e chama a Classe da aplicação #
Tradutor::Tradutor.new
