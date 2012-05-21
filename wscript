#!/usr/bin/env python
# encoding: utf-8
# Cameron Bytheway, 2011

import os

APPNAME = 'nujiistudio'
VERSION = '0.1'

top = '.'
out = 'build'

def options(ctx):
	plovr_default = ctx.path.abspath() + '/bin/plovr.jar'
	ctx.add_option('--plovr', action='store', default=plovr_default, help='Plovr build tool path')

	plovr_config = ctx.path.abspath() + '/etc/config.json'
	ctx.add_option('--plovr_config', action='store', default=plovr_config, help='Plovr config path')

	js_out = 'js/app.js'
	ctx.add_option('--js_out', action='store', default=js_out, help='Javascript outpath')

def configure(ctx):
	pass

def build(bld):
	_buildClosure(bld)

def _buildClosure(bld):
	src = bld.path.ant_glob('application/**/*js') + bld.path.ant_glob('lib/**/*js')
	bld(rule='java -jar "'+bld.options.plovr+'" build "'+bld.options.plovr_config+'" > '+bld.path.abspath()+'/build/'+bld.options.js_out, source=src, target=bld.options.js_out)
