




mumble-restricted-perms:
  file.managed:
    - name: /srv/projects/mumble/global-reset-perms.sh
    - mode: 750
    - user: mumble-user
    - group: editor
    - contents: |
            #!/usr/bin/env bash
            if [ -e "/srv/projects/mumble/pillar" ];then
            "/srv/salt/makina-states/_scripts/reset-perms.py" "${@}" \
              --dmode '0770' --fmode '0770' \
              --user root --group "editor" \
              --users root \
              --groups "editor" \
              --paths "/srv/projects/mumble/pillar";
            fi
            if [ -e "/srv/projects/mumble/project" ];then
              "/srv/salt/makina-states/_scripts/reset-perms.py" "${@}" \
              --dmode '0770' --fmode '0770'  \
              --paths "/srv/projects/mumble/project" \
              --paths "/srv/projects/mumble/data" \
              --users www-data \
              --users mumble-user \
              --groups editor \
              --user mumble-user \
              --group editor;
              "/srv/salt/makina-states/_scripts/reset-perms.py" "${@}" \
              --no-recursive -o\
              --dmode '0555' --fmode '0644'  \
              --paths "/srv/projects/mumble/project" \
              --paths "/srv/projects/mumble" \
              --paths "/srv/projects/mumble"/.. \
              --paths "/srv/projects/mumble"/../.. \
              --users www-data ;
            fi
  cmd.run:
    - name: /srv/projects/mumble/global-reset-perms.sh
    - cwd: /srv/projects/mumble/project
    - user: root
    - watch:
      - file: mumble-restricted-perms
