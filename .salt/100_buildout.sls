{% set cfg = opts.ms_project %}
{% set scfg = salt['mc_utils.json_dump'](cfg) %}
{% set data = cfg.data %}
{% set db = cfg.data.db %}

{{cfg.name}}-buildout:
  file.managed:
    - name: {{cfg.project_root}}/salt.cfg
    - source: salt://makina-projects/{{cfg.name}}/files/salt.cfg
    - template: jinja
    - user: {{cfg.user}}
    - data: |
            {{scfg}}
    - group: {{cfg.group}}
    - makedirs: true
  buildout.installed:
    - config: salt.cfg
    - name: {{cfg.project_root}}
    - use_vt: true
    - python: /usr/bin/python
    - output_loglevel: info
    - user: {{cfg.user}}
    - watch:
      - file: {{cfg.name}}-buildout
    - user: {{cfg.user}}
    - group: {{cfg.group}}
