function autopush
{
      git add .;
      git status;
      git status > /tmp/autopush.log
      git commit -m 'autopush';
      git tag -ma $1;
      git push --follow-tags;
}
