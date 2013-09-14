module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json'),

        coffee:
            main:
                files:
                    'src/js/helper.js': ['src/coffee/helper.coffee']

        less:
            main:
                options:
                    paths: ["less"],
                    yuicompress: true
                files:
                    "Bukowskis Market Helper.safariextension/css/bukowskis-helper.min.css" : "src/less/helper.less"

        uglify:
            options:
                banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
                        ' * Copyright (c) <%= grunt.template.today("yyyy") %> */\n'
            main:
                files: [
                    'Bukowskis Market Helper.safariextension/js/bukowskis-helper.min.js': ['src/js/jquery-2.0.3.js',
                    'src/js/helper.js'],
                ]

        watch:
            watch:
                files: ['src/coffee/*.coffee', 'src/less/*.less'],
                tasks: ['default'],
                options:
                    nospawn: true


    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    # grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('default', ['less', 'coffee', 'uglify'])
    # grunt.registerTask('dist', ['default', 'concat', 'uglify'])

