class nginx ($file = 'default') {

    # Nous pouvons utiliser la ressource de package pour s'assurer que Nginx est installé, et si il ne l'est pas,
    # il sera installé comme suit.
    package {"nginx":
        ensure => present
    }

    file { '/etc/nginx/sites-available/default':
        source => "puppet:///modules/nginx/${file}",
        owner => 'root',
        group => 'root',
        # Notifier au service ngnix le changement du ficher de configuration
        # => Redémarrage du service
        notify => Service['nginx'],
        require => [Package['nginx']]
    }

    # nous utilisons la ressource "service" pour s'assurer que le service de nginx est en cours d'exécution. De toute
    # évidence, cela ne peut pas être exécuté si nginx n'est pas installé, de sorte que le paquet nginx est une condition préalable
    service { "nginx":
        ensure => running,
        require => Package["nginx"]
    }
}