module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json'),

        coffee:
            main:
                files:
                    'helper.js': ['src/coffee/helper.coffee']

        less:
            main:
                options:
                    paths: ["less"],
                    yuicompress: true
                files:
                    "helper.css" : "src/less/helper.less"

        watch:
            watch:
                files: ['src/coffee/*.coffee', 'src/less/*.less'],
                tasks: ['default'],
                # options:
                #     nospawn: true


    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    # grunt.loadNpmTasks('grunt-contrib-concat');
    # grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('default', ['less', 'coffee'])
    # grunt.registerTask('dist', ['default', 'concat', 'uglify'])

