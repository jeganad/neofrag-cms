<h5><?php echo ($type['type'] == 1 ? icon('fa-crosshairs') : icon('fa-calendar-o')).' '.$title ?></h5>
<?php echo $this->label($type['title'], $type['icon'], $type['color'], 'events/type/'.$type['type_id'].'/'.url_title($type['title'])).' '.icon('fa-clock-o').timetostr('%H:%M', $date) ?>
<?php if ($description): ?>
<div class="mt-1">
	<?php echo str_shortener(strip_tags(str_replace('<br />', ' ', bbcode($description))), 90) ?>
</div>
<?php endif ?>