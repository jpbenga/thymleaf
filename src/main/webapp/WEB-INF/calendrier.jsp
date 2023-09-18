<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Calendrier</title>
<link
	th:href="@{'style/' + session.utilisateur.theme.nom.toLowerCase() + '.css'}"
	rel="stylesheet">
</head>
<body>
	<h1>Calendrier</h1>
	<h2>
		Utilisateur : <span th:text="${session.utilisateur.prenom}"></span> -
		solde : <span th:text="${session.utilisateur.nbPoints}"></span> points
		<a href="calendrier/deconnexion">Déconnexion</a>
	</h2>
	<table id="calendrier">
		<tr>
			<td>Jour</td>
			<td>Gif</td>
			<td>Utilisateur</td>
			<td>Réaction(s)</td>
		</tr>
		<tr th:each="jour : ${pageDeJours.content}">
			<td th:text="${jour}"></td>
			<td th:if="${jour.gif eq null }" colspan="3"><span
				th:text="${jour.nbPoints}"></span> points<br> <a
				th:href="'calendrier/placerGifDistant?ID_JOUR=' + ${jour.date}">Placer
					un Gif distant</a><br> <a
				th:href="'calendrier/televerserGif?ID_JOUR=' + ${jour.date}">Téléverser
					un Gif</a></td>
			<td th:if="${jour.gif ne null }"><span
				th:if="${jour.gif.legende ne null}" th:text="${jour.gif.legende}"></span>
				<img th:if="${jour.gif.getClass().simpleName eq 'GifDistant'}"
				th:src="${jour.gif.url}" height="200"> <img
				th:if="${jour.gif.getClass().simpleName eq 'GifTeleverse'}"
				th:src="'/images/' + ${jour.gif.id} + '.gif'" height="200"></td>
			<td th:if="${jour.gif ne null }"
				th:text="${jour.gif.utilisateur.prenom}"></td>
			<td th:if="${jour.gif ne null }"><span
				th:each="reaction : ${jour.gif.reactions}"
				th:text="${reaction.emotion.code} + ' ' + ${reaction.utilisateur.prenom}"></span><br>
				<a th:href="'calendrier/reagir?ID_GIF=' + ${jour.gif.id}">Réagir</a>
			</td>
		</tr>
	</table>
	<h2>
		<a th:if="${!pageDeJours.first}"
			th:href="'calendrier?page=0&sort=' + ${sort}">&#x23EE;</a> <a
			th:if="${!pageDeJours.first}"
			th:href="'calendrier?page=' + ${pageDeJours.number-1} + '&sort=' + ${sort}">&#x23EA;</a>

		Page <span th:text="${pageDeJours.number+1}"></span> : Jour <span
			th:text="${pageDeJours.totalElements == 0 ? 0 : pageDeJours.size * pageDeJours.number+1}"></span>
		à <span
			th:text="${pageDeJours.numberOfElements + (pageDeJours.size * pageDeJours.number)}"></span>
		sur <span th:text="${pageDeJours.totalElements}"></span> Jours <a
			th:if="${!pageDeJours.last}"
			th:href="'calendrier?page=' + ${pageDeJours.number+1} + '&sort=' + ${sort}">&#x23E9;</a>
		<a th:if="${!pageDeJours.last}"
			th:href="'calendrier?page=' + ${pageDeJours.totalPages - 1} + '&sort=' + ${sort}">&#x23ED;</a>

		<a th:href="'calendrierExport?jours=' + ${pageDeJours.number}">Exporter
			le calendrier en PDF</a>
	</h2>
</body>
</html>
